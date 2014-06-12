//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// TODO: Using functions as a workaround for a crashy compiler in beta 1. Will make these read-only properties in future update.
extension UIView {
	func lex_leading() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Leading)
	}
	func lex_trailing() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Trailing)
	}

	func lex_top() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Top)
	}
	func lex_left() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Left)
	}
	func lex_bottom() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Bottom)
	}
	func lex_right() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Right)
	}

	func lex_centerX() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .CenterX)
	}
	func lex_centerY() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .CenterY)
	}

	func lex_width() -> ItemDimensionArgument {
		return ItemDimensionArgument(item: self, attribute: .Width)
	}
	func lex_height() -> ItemDimensionArgument {
		return ItemDimensionArgument(item: self, attribute: .Height)
	}

	func lex_baseline() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self, attribute: .Baseline)
	}
}

extension UIView {
	func lex_edges() -> ItemEdgesArgument {
		return ItemEdgesArgument(item: self)
	}
}

extension UIView {
	func lex_center() -> ItemCenterArgument {
		return ItemCenterArgument(item: self)
	}
}

extension UIView {
	func lex_size() -> ItemSizeArgument {
		return ItemSizeArgument(item: self)
	}
}

// MARK: Adding to UIViews

extension UIView {
	// TODO: Re-enable this once Generics is good to go:
	/// Evaluates the distinct expression and adds the layout constraint to the view.
	/// Returns the layout constraint.
	//	func lex_addExpression(expression: Expression<DistinctArgument, DistinctArgument>) -> NSLayoutConstraint {
	//		let constraint = evaluateExpression(expression)
	//		self.addConstraint(constraint)
	//		return constraint
	//	}

	/// Evaluates `expression` and adds the layout constraints to the view.
	/// Returns the layout constraints.
	func lex_addExpression(expression: Expression) -> NSLayoutConstraint[] {
		return self.lex_addExpressions([ expression ])
	}

	/// Evaluates `expressions` and adds the layout constraints to the view.
	/// Returns the layout constraints.
	func lex_addExpressions(expressions: Expression...) -> NSLayoutConstraint[] {
		return self.lex_addExpressions(expressions)
	}

	/// Evaluates `expressions` and adds the layout constraints to the view.
	/// Returns the layout constraints.
	func lex_addExpressions(expressions: Expression[]) -> NSLayoutConstraint[] {
		let constraints = evaluateExpressions(expressions)
		self.addConstraints(constraints)
		return constraints
	}
}