//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

struct ItemDimensionArgument: DistinctLeftHandSideArgument, DistinctRightHandSideArgument {
	let _item: AnyObject
	let _attribute: NSLayoutAttribute

	init(item: AnyObject, attribute: NSLayoutAttribute) {
		assert(attribute == .Width || attribute == .Height)
		_item = item
		_attribute = attribute
	}

	// LeftHandSideArgument
	var item: AnyObject {
		return _item
	}

	var attributes: NSLayoutAttribute[] {
		return [ self.attribute ]
	}

	// DistinctLeftHandSideArgument
	var attribute: NSLayoutAttribute {
		return _attribute
	}

	// RightHandSideArgument
	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return self.attributeValues
	}

	// DistinctRightHandSideArgument
	var attributeValues: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return (item: _item, attribute: _attribute, multiplier: nil, constant: nil)
	}
}

// MARK: Comparison Operators

func ==(lhs: ItemDimensionArgument, rhs: ItemDimensionArgument) -> Expression {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemDimensionArgument, rhs: ItemDimensionArgument) -> Expression {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemDimensionArgument, rhs: ItemDimensionArgument) -> Expression {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

func ==(lhs: ItemDimensionArgument, constant: Float) -> Expression {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: ItemDimensionArgument, constant: Float) -> Expression {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: ItemDimensionArgument, constant: Float) -> Expression {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}