//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ------------------------------------------------------------------------------------------------
// MARK: - Argument Accessors

extension UIView {
	/// The distinct .Leading layout expression argument.
	public var lexLeading: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Leading)
	}

	/// The distinct .Trailing layout expression argument.
	public var lexTrailing: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Trailing)
	}

	/// The distinct .Top layout expression argument.
	public var lexTop: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Top)
	}

	/// The distinct .Left layout expression argument.
	public var lexLeft: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Left)
	}

	/// The distinct .Bottom layout expression argument.
	public var lexBottom: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Bottom)
	}

	/// The distinct .Right layout expression argument.
	public var lexRight: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Right)
	}

	/// The distinct .CenterX layout expression argument.
	public var lexCenterX: AttributeArgument {
		return AttributeArgument(item: self, attribute: .CenterX)
	}

	/// The distinct .CenterY layout expression argument.
	public var lexCenterY: AttributeArgument {
		return AttributeArgument(item: self, attribute: .CenterY)
	}

	/// The distinct .Width layout expression argument.
	public var lexWidth: DimensionArgument {
		return DimensionArgument(item: self, attribute: .Width)
	}

	/// The distinct .Height layout expression argument.
	public var lexHeight: DimensionArgument {
		return DimensionArgument(item: self, attribute: .Height)
	}

	/// The distinct .Baseline layout expression argument.
	public var lexBaseline: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Baseline)
	}
}

extension UIView {
	/// The composite "edges" layout expression argument.
	/// Evaluates to .Top, .Left, .Bottom, .Right constraints.
	public var lexEdges: EdgesArgument {
		return EdgesArgument(item: self)
	}
}

extension UIView {
	/// The composite "center" layout expression argument.
	/// Evaluates to .CenterX, .CenterY constraints.
	public var lexCenter: CenterArgument {
		return CenterArgument(item: self)
	}
}

extension UIView {
	/// The composite "size" layout expression argument.
	/// Evaluates to .Width, .Height constraints.
	public var lexSize: SizeArgument {
		return SizeArgument(item: self)
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Adding to UIViews

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
