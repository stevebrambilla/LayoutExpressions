//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

extension UIView {
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	public func addLayoutExpression<Left: DistinctLeftArgument, Right: DistinctRightArgument>(expression: Expression<Left, Right>) -> NSLayoutConstraint {
		let constraint = expression.evaluateDistinct()
		addConstraint(constraint)
		return constraint
	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpression<Left: LeftArgument, Right: RightArgument>(expression: Expression<Left, Right>) -> [NSLayoutConstraint] {
		let constraints = expression.evaluate()
		addConstraints(constraints)
		return constraints
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpressions<Left: LeftArgument, Right: RightArgument>(expressions: Expression<Left, Right>...) -> [NSLayoutConstraint] {
		let constraints = expressions.evaluate()
		addConstraints(constraints)
		return constraints
	}
}
