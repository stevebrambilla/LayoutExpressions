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

public struct SizeArgument: LeftArgument, RightArgument {
	private let item: AnyObject
	private let offset: SizeOffset?

	internal init(item: AnyObject, offset: SizeOffset? = nil) {
		self.item = item
		self.offset = offset
	}

	private func updateOffset(offset: SizeOffset) -> SizeArgument {
		return SizeArgument(item: item, offset: offset)
	}

	public var leftItem: AnyObject {
		return item
	}

	public var leftAttributes: [NSLayoutAttribute] {
		return [.Width, .Height]
	}

	public func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters {
		switch attribute {
		case .Width:
			return Parameters(item: item, attribute: .Width, multiplier: nil, constant: offset?.width)

		case .Height:
			return Parameters(item: item, attribute: .Height, multiplier: nil, constant: offset?.height)

		default:
			assert(false, "Called SizeArgument with an invalid attribute.")
			return Parameters.noop
		}
	}
}

public struct FixedSizeArgument: RightArgument {
	private let size: CGSize

	private init(size: CGSize) {
		self.size = size
	}

	public func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters {
		switch attribute {
		case .Width:
			return Parameters(item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: size.width)

		case .Height:
			return Parameters(item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: size.height)

		default:
			assert(false, "Called SizeArgument with an invalid attribute.")
			return Parameters.noop
		}
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Shorthand Structs

public struct SizeOffset {
	public var width: CGFloat
	public var height: CGFloat

	public init(width: CGFloat, height: CGFloat) {
		self.width = width
		self.height = height
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: SizeArgument, offset: SizeOffset) -> SizeArgument {
	return lhs.updateOffset(offset)
}

// ------------------------------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == (lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= (lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= (lhs: SizeArgument, rhs: SizeArgument) -> Expression<SizeArgument, SizeArgument> {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func == (lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= (lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= (lhs: SizeArgument, rhsSize: CGSize) -> Expression<SizeArgument, FixedSizeArgument> {
	let rhs = FixedSizeArgument(size: rhsSize)
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
