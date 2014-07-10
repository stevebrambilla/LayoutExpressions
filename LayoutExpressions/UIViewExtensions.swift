//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// TODO: Using functions as a workaround for a crashy compiler in beta 1. Will make these read-only properties in future update.
extension UIView {
	/// The distinct .Leading layout expression argument.
	func lex_leading() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Leading)
	}

	/// The distinct .Trailing layout expression argument.
	func lex_trailing() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Trailing)
	}

	/// The distinct .Top layout expression argument.
	func lex_top() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Top)
	}

	/// The distinct .Left layout expression argument.
	func lex_left() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Left)
	}

	/// The distinct .Bottom layout expression argument.
	func lex_bottom() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Bottom)
	}

	/// The distinct .Right layout expression argument.
	func lex_right() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Right)
	}

	/// The distinct .CenterX layout expression argument.
	func lex_centerX() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .CenterX)
	}

	/// The distinct .CenterY layout expression argument.
	func lex_centerY() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .CenterY)
	}

	/// The distinct .Width layout expression argument.
	func lex_width() -> ItemDimensionArgument {
		return ItemDimensionArgument(item: self, attribute: .Width)
	}

	/// The distinct .Height layout expression argument.
	func lex_height() -> ItemDimensionArgument {
		return ItemDimensionArgument(item: self, attribute: .Height)
	}

	/// The distinct .Baseline layout expression argument.
	func lex_baseline() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Baseline)
	}
}

extension UIView {
	/// The composite "edges" layout expression argument.
	/// Evaluates to .Top, .Left, .Bottom, .Right constraints.
	func lex_edges() -> ItemEdgesArgument {
		return ItemEdgesArgument(item: self)
	}
}

extension UIView {
	/// The composite "center" layout expression argument.
	/// Evaluates to .CenterX, .CenterY constraints.
	func lex_center() -> ItemCenterArgument {
		return ItemCenterArgument(item: self)
	}
}

extension UIView {
	/// The composite "size" layout expression argument.
	/// Evaluates to .Width, .Height constraints.
	func lex_size() -> ItemSizeArgument {
		return ItemSizeArgument(item: self)
	}
}

// MARK: Adding to UIViews

extension UIView {
	// TODO: Re-enable this once Generics is good to go:
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	///
	/// Returns the layout constraint.
	//	func lex_addExpression(expression: Expression<DistinctArgument, DistinctArgument>) -> NSLayoutConstraint {
	//		let constraint = evaluateExpression(expression)
	//		self.addConstraint(constraint)
	//		return constraint
	//	}

	/// Evaluates the expression and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	func lex_addExpression(expression: Expression) -> [NSLayoutConstraint] {
		return self.lex_addExpressions([ expression ])
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	func lex_addExpressions(expressions: Expression...) -> [NSLayoutConstraint] {
		return self.lex_addExpressions(expressions)
	}

	/// Evaluates the expressions and adds the constraints to the view.
	///
	/// Returns the layout constraints.
	func lex_addExpressions(expressions: [Expression]) -> [NSLayoutConstraint] {
		let constraints = evaluateExpressions(expressions)
		self.addConstraints(constraints)
		return constraints
	}
}