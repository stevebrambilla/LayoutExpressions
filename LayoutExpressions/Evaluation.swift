//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

/// Evaluates a distinct layout expression into a single constraint.
///
/// Returns an evaluated NSLayoutConstraint
public func evaluateLayoutExpression(_ expression: DistinctExpressionType) -> NSLayoutConstraint {
	return expression.evaluateDistinct()
}

/// Evaluates a layout expression into constraints.
///
/// Returns an array of layout constraints.
public func evaluateLayoutExpression(_ expression: ExpressionProtocol) -> [NSLayoutConstraint] {
	return expression.evaluateAll()
}

/// Evaluates multiple layout expressions into constraints.
///
/// Returns an array of layout constraints.
public func evaluateLayoutExpressions(_ expressions: [ExpressionProtocol]) -> [NSLayoutConstraint] {
	return expressions.reduce([]) { acc, expression in
		return acc + expression.evaluateAll()
	}
}
