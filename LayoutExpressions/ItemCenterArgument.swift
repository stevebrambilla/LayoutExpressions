//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning the center to another view:
// 		subview.center == container.center
//
// With an optional offset:
// 		subview.center == container.center + (horizontal: 0.0, vertical: -10.0)

struct PointOffset {
	var horizontal: CGFloat
	var vertical: CGFloat

	init(horizontal: CGFloat, vertical: CGFloat) {
		self.horizontal = horizontal
		self.vertical = vertical
	}

	init(_ offset: UIOffset) {
		self.init(horizontal: offset.horizontal, vertical: offset.vertical)
	}

	init(_ point: CGPoint) {
		self.init(horizontal: point.x, vertical: point.y)
	}
}

// MARK: Center Argument

class ItemCenterArgument: LeftHandSideArgument, RightHandSideArgument {
	let _item: AnyObject
	let _offset: PointOffset?

	init(item: AnyObject, offset: PointOffset? = nil) {
		_item = item
		_offset = offset
	}

	func updateOffset(offset: PointOffset) -> ItemCenterArgument {
		return ItemCenterArgument(item: _item, offset: offset)
	}

	// LeftHandSideArgument
	var item: AnyObject {
		return _item
	}

	var attributes: [NSLayoutAttribute] {
		return [ .CenterX, .CenterY ]
	}

	// RightHandSideArgument
	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
		case .CenterX:
			return (item: _item, attribute: .CenterX, multiplier: nil, constant: _offset?.horizontal)
		case .CenterY:
			return (item: _item, attribute: .CenterY, multiplier: nil, constant: _offset?.vertical)
		default:
			assert(false, "Called ItemCenterArgument with an invalid left attribute.")
			return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: nil)
		}
	}
}

@infix func +(lhs: ItemCenterArgument, offset: PointOffset) -> ItemCenterArgument {
	return lhs.updateOffset(offset)
}

// MARK: Comparison Operators

func ==(lhs: ItemCenterArgument, rhs: ItemCenterArgument) -> Expression {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}
