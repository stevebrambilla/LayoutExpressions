//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

class DimensionArgument: AttributeArgument {
	init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
		assert(attribute == .Width || attribute == .Height)
		super.init(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}
}

// MARK: Comparison Operators

func ==(lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

func <=(lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

func >=(lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}