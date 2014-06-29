//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// MARK: Size

// Supports constraining the size to another view:
//     subview.size == sibling.size
//     subview.size >= sibling.size
//     subview.size <= sibling.size
//
// With an optional offset
//     subview.size == sibling.size + (width: 20.0, height: 20.0)
//
// Supports constraining the size to a CGSize:
//     subview.size == (width: 320.0, height: 480.0)

struct SizeOffset {
	var width: CGFloat
	var height: CGFloat
}

// MARK: Size Arguments

class ItemSizeArgument: LeftHandSideArgument, RightHandSideArgument {
	let _item: AnyObject
	let _offset: SizeOffset?

	init(item: AnyObject, offset: SizeOffset? = nil) {
		_item = item
		_offset = offset
	}

	func updateOffset(offset: SizeOffset) -> ItemSizeArgument {
		return ItemSizeArgument(item: _item, offset: offset)
	}

	var item: AnyObject {
		return _item
	}

	var attributes: NSLayoutAttribute[] {
		return [ .Width, .Height ]
	}

	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
			case .Width:
				return (_item, .Width, nil, _offset?.width)
			case .Height:
				return (_item, .Height, nil, _offset?.height)
			default:
				assert(false, "Called ItemSizeArgument with an invalid left attribute.")
				return (_item, .NotAnAttribute, nil, nil)
		}
	}
}

@infix func +(lhs: ItemSizeArgument, offset: SizeOffset) -> ItemSizeArgument {
	return lhs.updateOffset(offset)
}

// MARK: Fixed Size Argument

class FixedSizeArgument: RightHandSideArgument {
	let _size: CGSize

	init(size: CGSize) {
		_size = size
	}

	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
			case .Width:
				return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: _size.width)
			case .Height:
				return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: _size.height)
			default:
				assert(false, "Called ItemSizeArgument with an invalid left attribute.")
				return (nil, .NotAnAttribute, nil, nil)
			}
	}
}

// MARK: Comparison Operators

func ==(lhs: ItemSizeArgument, rhs: ItemSizeArgument) -> Expression {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemSizeArgument, rhs: ItemSizeArgument) -> Expression {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemSizeArgument, rhs: ItemSizeArgument) -> Expression {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

func ==(lhs: ItemSizeArgument, rhsSize: CGSize) -> Expression {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemSizeArgument, rhsSize: CGSize) -> Expression {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemSizeArgument, rhsSize: CGSize) -> Expression {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}