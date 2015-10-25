//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

extension UIView {
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	public func addLayoutExpression<Left: DistinctLeftHandSideArgument, Right: DistinctRightHandSideArgument>(expression: Expression<Left, Right>) -> NSLayoutConstraint {
		let constraint = evaluateExpression(expression)
		addConstraint(constraint)
		return constraint
	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpression<Left: LeftHandSideArgument, Right: RightHandSideArgument>(expression: Expression<Left, Right>) -> [NSLayoutConstraint] {
		return addLayoutExpressions(expression)
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpressions<Left: LeftHandSideArgument, Right: RightHandSideArgument>(expressions: Expression<Left, Right>...) -> [NSLayoutConstraint] {
		let constraints = evaluateExpressions(expressions)
		addConstraints(constraints)
		return constraints
	}
}
