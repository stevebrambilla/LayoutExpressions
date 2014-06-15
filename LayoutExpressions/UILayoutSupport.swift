//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// UIViewControllers has layout guides (objects that conform to the
// UILayoutSupport protocol). But we cannot extend a protocol with concrete
// methods, so we
// have to bring the UILayoutSupport objects
// into our expressions by converting them to ItemAttributeArguments.
//
// We provide two ways to do this: a UIViewController extension that adds
// `lex_`-prefixed variants of the layoutGuide properties. These use the
// 'opposite' edge as the argument's attribute.
//
//     view.lex_top == viewController.lex_topLayoutGuide
//
// Or use one of the UILayoutSupport functions, which allows you to explicitly
// specify the edge attribute and return a ItemAttributeArgument.
//
//     view.lex_leading == leadingEdgeOf(viewController.leftLayoutGuide)

// MARK: UIViewController Extensions

extension UIViewController {
	func lex_topLayoutGuide() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self.topLayoutGuide, attribute: oppositeEdgeAttribute(.Top))
	}
	func lex_leftLayoutGuide() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self.leftLayoutGuide, attribute: oppositeEdgeAttribute(.Left))
	}
	func lex_bottomLayoutGuide() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self.bottomLayoutGuide, attribute: oppositeEdgeAttribute(.Bottom))
	}
	func lex_rightLayoutGuide() -> ItemAttributeArgument {
		return ItemAttributeArgument(item: self.rightLayoutGuide, attribute: oppositeEdgeAttribute(.Right))
	}
}

// MARK: UILayoutSupport Functions

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

func oppositeEdgeAttribute(attribute: NSLayoutAttribute) -> NSLayoutAttribute {
	switch attribute {
		case .Leading:
			return .Trailing
		case .Trailing:
			return .Leading
		case .Top:
			return .Bottom
		case .Left:
			return .Right
		case .Bottom:
			return .Top
		case .Right:
			return .Left
		default:
			return .NotAnAttribute
	}
}