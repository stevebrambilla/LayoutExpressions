//  Copyright © 2019 Steve Brambilla. All rights reserved.

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#else
import UIKit
#endif

// MARK: - ***Experimental***

#if swift(>=5.1)

// The Swift 5.1 implementation of function builders is not implemented according to the draft
// proposal.
//
// We should be able to simplify a lot of this in Swift 5.2 -- once @functionBuilder proper lands --
// including removing the temporary `LayoutExpression` type, and simplifying the `LayoutBuilder`
// implementation itself.
//
// This all works in the mean time, but should be considered experimental.

@_functionBuilder
public struct LayoutBuilder {
    public static func buildBlock(_ expression: ExpressionProtocol) -> ExpressionProtocol {
        return LayoutExpression(expression: expression)
    }
    
    public static func buildBlock(_ children: ExpressionProtocol...) -> ExpressionProtocol {
        return LayoutExpression(expressions: children)
    }
    
    public static func buildIf(_ expression: ExpressionProtocol?) -> ExpressionProtocol {
        return LayoutExpression(expression: expression)
    }
    
    public static func buildEither(first: ExpressionProtocol) -> ExpressionProtocol {
        return LayoutExpression(expression: first)
    }
    
    public static func buildEither(second: ExpressionProtocol) -> ExpressionProtocol {
        return LayoutExpression(expression: second)
    }
}

/// A layout expression built up using `LayoutBuilder`.
///
/// This is an implementation detail. Don't use on its own.
public struct LayoutExpression: ExpressionProtocol {
    private let constraints: [NSLayoutConstraint]
    
    fileprivate init(expression: ExpressionProtocol?) {
        constraints = expression?.evaluateAll() ?? []
    }
    
    fileprivate init(expressions: [ExpressionProtocol]) {
        constraints = expressions.flatMap { $0.evaluateAll() }
    }
    
    public func update(priority: Priority) -> LayoutExpression {
        return self // Do nothing
    }
    
    public func evaluateAll() -> [NSLayoutConstraint] {
        return constraints
    }
}

/// Builds a set of layout expressions and evaluates them into constraints.
///
/// Returns an array of layout constraints.
public func evaluateLayout(@LayoutBuilder makeLayout: () -> ExpressionProtocol) -> [NSLayoutConstraint] {
    makeLayout().evaluateAll()
}

/// Builds and activates a set of layout expressions.
///
/// The effect of this function is the same as setting the `isActive` property of the constraints to
/// `true`.
public func activateLayout(@LayoutBuilder makeLayout: () -> ExpressionProtocol) {
    makeLayout().evaluateAll().activateConstraints()
}

#endif
