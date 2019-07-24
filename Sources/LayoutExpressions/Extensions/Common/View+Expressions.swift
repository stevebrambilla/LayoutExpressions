//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

extension View {
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	@discardableResult
	public func addLayoutExpression(_ expression: DistinctExpressionProtocol) -> Constraint {
		let constraint = Constraint.evaluate(expression)
		addConstraint(constraint)
		return constraint
	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	@discardableResult
	public func addLayoutExpression(_ expression: ExpressionProtocol) -> [Constraint] {
		let constraints = Constraint.evaluate(expression)
		addConstraints(constraints)
		return constraints
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	@discardableResult
	public func addLayoutExpressions(_ expressions: ExpressionProtocol...) -> [Constraint] {
		let constraints = Constraint.evaluate(expressions)
		addConstraints(constraints)
		return constraints
	}
}
