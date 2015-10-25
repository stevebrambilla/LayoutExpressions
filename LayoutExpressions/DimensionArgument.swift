//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ------------------------------------------------------------------------------------------------
// MARK: - Argument

public class DimensionArgument: AttributeArgument {
	override init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
		assert(attribute == .Width || attribute == .Height)
		super.init(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == (lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= (lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= (lhs: DimensionArgument, constant: CGFloat) -> Expression<DimensionArgument, ConstantArgument> {
	let rhs = ConstantArgument(constant: constant)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
