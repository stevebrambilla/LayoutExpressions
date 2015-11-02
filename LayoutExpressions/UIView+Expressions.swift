//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

extension UIView {
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	public func addLayoutExpression(expression: DistinctExpressionType) -> NSLayoutConstraint {
		let constraint = evaluateLayoutExpression(expression)
		addConstraint(constraint)
		return constraint
	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpression(expression: ExpressionType) -> [NSLayoutConstraint] {
		let constraints = evaluateLayoutExpression(expression)
		addConstraints(constraints)
		return constraints
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func addLayoutExpressions(expressions: ExpressionType...) -> [NSLayoutConstraint] {
		let constraints = evaluateLayoutExpressions(expressions)
		addConstraints(constraints)
		return constraints
	}
}