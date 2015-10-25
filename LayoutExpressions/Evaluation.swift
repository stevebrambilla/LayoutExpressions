//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import Foundation

/// Evaluates a distinct layout expression into a single constraint.
///
/// Returns an evaluated NSLayoutConstraint
public func lexEvaluate<Left: DistinctLeftArgument, Right: DistinctRightArgument>(expression: Expression<Left, Right>) -> NSLayoutConstraint {
	return expression.evaluateDistinct()
}

/// Evaluates a layout expression into constraints.
///
/// Returns an array of layout constraints.
public func lexEvaluate<Left, Right>(expression: Expression<Left, Right>) -> [NSLayoutConstraint] {
	return expression.evaluate()
}

/// Evaluates multiple layout expressions into constraints.
///
/// Returns an array of layout constraints.
public func lexEvaluate<Left, Right>(expressions: [Expression<Left, Right>]) -> [NSLayoutConstraint] {
	return expressions.evaluate()
}
