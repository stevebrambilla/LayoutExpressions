//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

class ItemDimensionArgument: ItemAttributeArgument {
	init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: Float? = nil, constant: Float? = nil) {
		assert(attribute == .Width || attribute == .Height)
		super.init(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}
}

// MARK: Comparison Operators

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