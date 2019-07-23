//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#else
import UIKit
#endif

/// Evaluates a distinct layout expression into a single constraint.
///
/// Returns an evaluated constraint.
public func evaluateLayoutExpression(_ expression: DistinctExpressionProtocol) -> Constraint {
	expression.evaluateDistinct()
}

/// Evaluates a layout expression into constraints.
///
/// Returns an array of layout constraints.
public func evaluateLayoutExpression(_ expression: ExpressionProtocol) -> [Constraint] {
	expression.evaluateAll()
}

/// Evaluates multiple layout expressions into constraints.
///
/// Returns an array of layout constraints.
public func evaluateLayoutExpressions(_ expressions: [ExpressionProtocol]) -> [Constraint] {
	expressions.reduce([]) { acc, expression in
		return acc + expression.evaluateAll()
	}
}

/// Evaluates a distinct layout expression and activates the constraint.
///
/// The effect of this function is the same as setting the `isActive` property of the constraint to
/// `true`.
public func activateLayoutExpression(_ expression: DistinctExpressionProtocol) {
	evaluateLayoutExpression(expression).isActive = true
}

/// Evaluates a layout expression and activates its constraints.
///
/// The effect of this function is the same as setting the `isActive` property of the constraints to
/// `true`.
public func activateLayoutExpression(_ expression: ExpressionProtocol) {
	evaluateLayoutExpression(expression).activateConstraints()
}

/// Evaluates multiple layout expressions and activates their constraints.
///
/// The effect of this function is the same as setting the `isActive` property of each constraint
/// to `true`.
public func activateLayoutExpressions(_ expressions: [ExpressionProtocol]) {
	evaluateLayoutExpressions(expressions).activateConstraints()
}
