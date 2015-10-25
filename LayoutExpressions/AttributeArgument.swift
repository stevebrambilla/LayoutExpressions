//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public struct AttributeArgument: DistinctLeftArgument, DistinctRightArgument {
	private let item: AnyObject
	private let attribute: NSLayoutAttribute
	private let multiplier: CGFloat?
	private let constant: CGFloat?

	internal init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
		self.item = item
		self.attribute = attribute
		self.multiplier = multiplier
		self.constant = constant
	}

	private func updateMultiplier(multiplier: CGFloat) -> AttributeArgument {
		return AttributeArgument(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}

	private func updateConstant(constant: CGFloat) -> AttributeArgument {
		return AttributeArgument(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}

	public var leftItem: AnyObject {
		return item
	}

	public var distinctLeftAttribute: NSLayoutAttribute {
		return attribute
	}

	public var distinctRightParameters: Parameters {
		return Parameters(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func * (lhs: AttributeArgument, multiplier: CGFloat) -> AttributeArgument {
	return lhs.updateMultiplier(multiplier)
}

public func * (multiplier: CGFloat, rhs: AttributeArgument) -> AttributeArgument {
	return rhs.updateMultiplier(multiplier)
}

public func + (lhs: AttributeArgument, constant: CGFloat) -> AttributeArgument {
	return lhs.updateConstant(constant)
}

public func - (lhs: AttributeArgument, constant: CGFloat) -> AttributeArgument {
	return lhs.updateConstant(-constant)
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == (lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= (lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= (lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
