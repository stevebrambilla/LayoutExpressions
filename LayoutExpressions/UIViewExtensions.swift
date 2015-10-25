//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ------------------------------------------------------------------------------------------------
// MARK: - Argument Accessors

extension UIView {
	/// The distinct .Leading layout expression argument.
	public var lex_leading: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Leading)
	}

	/// The distinct .Trailing layout expression argument.
	public var lex_trailing: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Trailing)
	}

	/// The distinct .Top layout expression argument.
	public var lex_top: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Top)
	}

	/// The distinct .Left layout expression argument.
	public var lex_left: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Left)
	}

	/// The distinct .Bottom layout expression argument.
	public var lex_bottom: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Bottom)
	}

	/// The distinct .Right layout expression argument.
	public var lex_right: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Right)
	}

	/// The distinct .CenterX layout expression argument.
	public var lex_centerX: AttributeArgument {
		return AttributeArgument(item: self, attribute: .CenterX)
	}

	/// The distinct .CenterY layout expression argument.
	public var lex_centerY: AttributeArgument {
		return AttributeArgument(item: self, attribute: .CenterY)
	}

	/// The distinct .Width layout expression argument.
	public var lex_width: DimensionArgument {
		return DimensionArgument(item: self, attribute: .Width)
	}

	/// The distinct .Height layout expression argument.
	public var lex_height: DimensionArgument {
		return DimensionArgument(item: self, attribute: .Height)
	}

	/// The distinct .Baseline layout expression argument.
	public var lex_baseline: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Baseline)
	}
}

extension UIView {
	/// The composite "edges" layout expression argument.
	/// Evaluates to .Top, .Left, .Bottom, .Right constraints.
	public var lex_edges: EdgesArgument {
		return EdgesArgument(item: self)
	}
}

extension UIView {
	/// The composite "center" layout expression argument.
	/// Evaluates to .CenterX, .CenterY constraints.
	public var lex_center: CenterArgument {
		return CenterArgument(item: self)
	}
}

extension UIView {
	/// The composite "size" layout expression argument.
	/// Evaluates to .Width, .Height constraints.
	public var lex_size: SizeArgument {
		return SizeArgument(item: self)
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Adding to UIViews

extension UIView {
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	public func lex_addExpression<L: DistinctLeftHandSideArgument, R: DistinctRightHandSideArgument>(expression: Expression<L, R>) -> NSLayoutConstraint {
		let constraint = evaluateExpression(expression)
		self.addConstraint(constraint)
		return constraint
	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func lex_addExpression<L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>) -> [NSLayoutConstraint] {
		return self.lex_addExpressions(expression)
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	public func lex_addExpressions<L: LeftHandSideArgument, R: RightHandSideArgument>(expressions: Expression<L, R>...) -> [NSLayoutConstraint] {
		let constraints = evaluateExpressions(expressions)
		self.addConstraints(constraints)
		return constraints

		//return self.lex_addExpressions(expressions)
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	// TODO: This function strill crashes the Swift compiler as of b5
	/*
	public func lex_addExpressions<L: LeftHandSideArgument, R: RightHandSideArgument>(expressions: [Expression<L, R>]) -> [NSLayoutConstraint] {
		let constraints = evaluateExpressions(expressions)
		self.addConstraints(constraints)
		return constraints
	}
	*/
}
