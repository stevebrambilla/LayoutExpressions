//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ------------------------------------------------------------------------------------------------
// MARK: - Argument

public class AttributeArgument: DistinctLeftHandSideArgument, DistinctRightHandSideArgument {
	private let item: AnyObject
	private let attribute: NSLayoutAttribute
	private let multiplier: CGFloat?
	private let constant: CGFloat?

	init(item: AnyObject, attribute: NSLayoutAttribute, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
		self.item = item
		self.attribute = attribute
		self.multiplier = multiplier
		self.constant = constant
	}

	func updateMultiplier(multiplier: CGFloat) -> AttributeArgument {
		return AttributeArgument(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}

	func updateConstant(constant: CGFloat) -> AttributeArgument {
		return AttributeArgument(item: item, attribute: attribute, multiplier: multiplier, constant: constant)
	}

	// LeftHandSideArgument
	public var leftHandSideItem: AnyObject {
		return item
	}
	public var leftHandSideAttributes: [NSLayoutAttribute] {
		return [ attribute ]
	}

	// DistinctLeftHandSideArgument
	public var distinctLeftHandSideAttribute: NSLayoutAttribute {
		return attribute
	}

	// RightHandSideArgument
	public func rightHandSideValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return self.distinctRightHandSideValue
	}

	// DistinctRightHandSideArgument
	public var distinctRightHandSideValue: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return (item:item, attribute: attribute, multiplier: multiplier, constant: constant)
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Arithmetic Operators

// Note: Order of operations still matters if using a multiplier AND constant.
// We _could_ use additional types to prevent multiple '*' / '+' / '-' operations...

public func *(lhs: AttributeArgument, multiplier: CGFloat) -> AttributeArgument {
	return lhs.updateMultiplier(multiplier)
}

public func *(multiplier: CGFloat, rhs: AttributeArgument) -> AttributeArgument {
	return rhs.updateMultiplier(multiplier)
}

public func +(lhs: AttributeArgument, constant: CGFloat) -> AttributeArgument {
	return lhs.updateConstant(constant)
}

public func -(lhs: AttributeArgument, constant: CGFloat) -> AttributeArgument {
	return lhs.updateConstant(-constant)
}

// ------------------------------------------------------------------------------------------------
// MARK: - Comparison Operators

public func ==(lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <=(lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >=(lhs: AttributeArgument, rhs: AttributeArgument) -> Expression<AttributeArgument, AttributeArgument> {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
