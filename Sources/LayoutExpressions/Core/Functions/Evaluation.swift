//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

extension Constraint {
    /// Evaluates a distinct layout expression into a single constraint.
    ///
    /// Returns an evaluated constraint.
    public static func evaluate(_ expression: DistinctExpressionProtocol) -> Constraint {
        expression.evaluateDistinct()
    }

    /// Evaluates a layout expression into constraints.
    ///
    /// Returns an array of layout constraints.
    public static func evaluate(_ expression: ExpressionProtocol) -> [Constraint] {
        expression.evaluateAll()
    }

    /// Evaluates multiple layout expressions into constraints.
    ///
    /// Returns an array of layout constraints.
    public static func evaluate(_ expressions: [ExpressionProtocol]) -> [Constraint] {
        expressions.reduce([]) { acc, expression in
            return acc + expression.evaluateAll()
        }
    }
}

extension Constraint {
    /// Evaluates a distinct layout expression and activates the constraint.
    ///
    /// The effect of this function is the same as setting the `isActive` property of the constraint to
    /// `true`.
    public static func activate(_ expression: DistinctExpressionProtocol) {
        evaluate(expression).isActive = true
    }

    /// Evaluates a layout expression and activates its constraints.
    ///
    /// The effect of this function is the same as setting the `isActive` property of the constraints to
    /// `true`.
    public static func activate(_ expression: ExpressionProtocol) {
        evaluate(expression).activateConstraints()
    }

    /// Evaluates multiple layout expressions and activates their constraints.
    ///
    /// The effect of this function is the same as setting the `isActive` property of each constraint
    /// to `true`.
    public static func activate(_ expressions: [ExpressionProtocol]) {
        evaluate(expressions).activateConstraints()
    }
}
