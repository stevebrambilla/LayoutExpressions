//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// UIViewControllers uses layout guides that conform to the UILayoutSupport
// protocol. But we cannot extend the protocol with concrete methods, so we
// have have two ways to bring the UILayoutSupport objects
// into our expressions: Implicitly and Explicitly.
//
// Implicit: Just use the layout guide on the right hand side of a layout
// expression. The right-hand-side attribute will match the left-hand-side
// attribute, which is often desired:
//
//     view.lex_top == viewController.topLayoutGuide
//
// Explicit: Use one of the explicit functions to specify an edge. This is
// the only way to add multipliers or constants to the expression:
//
//     view.lex_leading == leadingEdgeOf(viewController.leftLayoutGuide)

// MARK: Explicit Functions

func leadingEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Leading)
}
func trailingEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Trailing)
}

func topEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Top)
}
func leftEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Left)
}
func bottomEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Bottom)
}
func rightEdgeOf(support: UILayoutSupport) -> ItemAttributeArgument {
	return ItemAttributeArgument(item: support, attribute: .Right)
}

// MARK: Implicit Comparison Operators

func ==(lhs: ItemAttributeArgument, support: UILayoutSupport) -> Expression {
	let rhs = ItemAttributeArgument(item: support, attribute: lhs.attribute)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemAttributeArgument, support: UILayoutSupport) -> Expression {
	let rhs = ItemAttributeArgument(item: support, attribute: lhs.attribute)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemAttributeArgument, support: UILayoutSupport) -> Expression {
	let rhs = ItemAttributeArgument(item: support, attribute: lhs.attribute)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}