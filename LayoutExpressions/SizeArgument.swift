//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

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

// ------------------------------------------------------------------------------------------------
// MARK: - Shorthand Structs

public struct SizeOffset {
	var width: CGFloat
	var height: CGFloat

	public init(width: CGFloat, height: CGFloat) {
		self.width = width
		self.height = height
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Arguments

public class SizeArgument: LeftHandSideArgument, RightHandSideArgument {
	private let item: AnyObject
	private let offset: SizeOffset?

	init(item: AnyObject, offset: SizeOffset? = nil) {
		self.item = item
		self.offset = offset
	}

	func updateOffset(offset: SizeOffset) -> SizeArgument {
		return SizeArgument(item: item, offset: offset)
	}

	// LeftHandSideArgument
	public var leftHandSideItem: AnyObject {
		return item
	}
	public var leftHandSideAttributes: [NSLayoutAttribute] {
		return [ .Width, .Height ]
	}

	// RightHandSideArgument
	public func rightHandSideValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
		case .Width:
			return (item, .Width, nil, offset?.width)
		case .Height:
			return (item, .Height, nil, offset?.height)
		default:
			assert(false, "Called SizeArgument with an invalid left attribute.")
			return (item, .NotAnAttribute, nil, nil)
		}
	}
}

public class FixedSizeArgument: RightHandSideArgument {
	private let size: CGSize

	init(size: CGSize) {
		self.size = size
	}

	// RightHandSideArgument
	public func rightHandSideValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
		case .Width:
			return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: size.width)
		case .Height:
			return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: size.height)
		default:
			assert(false, "Called SizeArgument with an invalid left attribute.")
			return (nil, .NotAnAttribute, nil, nil)
		}
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func +(lhs: SizeArgument, offset: SizeOffset) -> SizeArgument {
	return lhs.updateOffset(offset)
}

// ------------------------------------------------------------------------------------------------
// MARK: - Comparison Operators

public func ==(lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <=(lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >=(lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func ==(lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <=(lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >=(lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
