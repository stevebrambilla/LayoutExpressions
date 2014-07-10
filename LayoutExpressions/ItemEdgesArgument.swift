//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning all edges:
// 		subview.allEdges == container.allEdges
//
// Supports insets using the '-' operator with a EdgeInsets struct:
//     	subview.allEdges == container.allEdges - (top: 10.0, left: 5.0, bottom: 5.0, right: 10.0)
//
// Or inset all edges equally using '-' with a Double:
// 		subview.allEdges == container.allEdges - 10.0

struct EdgeInsets {
	let top: CGFloat
	let left: CGFloat
	let bottom: CGFloat
	let right: CGFloat

	init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
		self.top = top
		self.left = left
		self.bottom = bottom
		self.right = right
	}

	init(_ insets: UIEdgeInsets) {
		self.init(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
	}
}

// MARK: Edges Argument

class ItemEdgesArgument: LeftHandSideArgument, RightHandSideArgument {
	let _item: AnyObject
	let _insets: EdgeInsets?

	init(item: AnyObject, insets: EdgeInsets? = nil) {
		_item = item
		_insets = insets
	}

	func updateInsets(insets: EdgeInsets) -> ItemEdgesArgument {
		return ItemEdgesArgument(item: _item, insets: insets)
	}

	// LeftHandSideArgument
	var item: AnyObject {
		return _item
	}

	var attributes: [NSLayoutAttribute] {
		return [ .Top, .Left, .Bottom, .Right ]
	}

	// RightHandSideArgument
	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
		case .Top:
			return (item: _item, attribute: .Top, multiplier: nil, constant: _insets?.top)
		case .Left:
			return (item: _item, attribute: .Left, multiplier: nil, constant: _insets?.left)
		case .Bottom:
			let bottomInset: CGFloat? = _insets ? -_insets!.bottom : nil
			return (item: _item, attribute: .Bottom, multiplier: nil, constant: bottomInset)
		case .Right:
			let rightInset: CGFloat? = _insets ? -_insets!.right : nil
			return (item: _item, attribute: .Right, multiplier: nil, constant: rightInset)
		default:
			assert(false, "Called EdgesArgument with an invalid left attribute.")
			return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: nil)
		}
	}
}

@infix func -(lhs: ItemEdgesArgument, inset: CGFloat) -> ItemEdgesArgument {
	let insets = EdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	return lhs.updateInsets(insets)
}

@infix func -(lhs: ItemEdgesArgument, insets: EdgeInsets) -> ItemEdgesArgument {
	return lhs.updateInsets(insets)
}

// MARK: Comparison Operators

func ==(lhs: ItemEdgesArgument, rhs: ItemEdgesArgument) -> Expression {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemEdgesArgument, rhs: ItemEdgesArgument) -> Expression {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemEdgesArgument, rhs: ItemEdgesArgument) -> Expression {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}