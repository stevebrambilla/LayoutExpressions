//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public struct DimensionArgument: DistinctLeftArgument, DistinctRightArgument {
	internal enum Dimension {
		case Width
		case Height

		private var attribute: NSLayoutAttribute {
			switch self {
			case .Width: return .Width
			case .Height: return .Height
			}
		}
	}

	private let item: AnyObject
	private let dimension: Dimension
	private let multiplier: CGFloat?
	private let constant: CGFloat?

	internal init(item: AnyObject, dimension: Dimension, multiplier: CGFloat? = nil, constant: CGFloat? = nil) {
		self.item = item
		self.dimension = dimension
		self.multiplier = multiplier
		self.constant = constant
	}

	internal func updateMultiplier(multiplier: CGFloat) -> DimensionArgument {
		return DimensionArgument(item: item, dimension: dimension, multiplier: multiplier, constant: constant)
	}

	internal func updateConstant(constant: CGFloat) -> DimensionArgument {
		return DimensionArgument(item: item, dimension: dimension, multiplier: multiplier, constant: constant)
	}

	public var leftItem: AnyObject {
		return item
	}

	public var distinctLeftAttribute: NSLayoutAttribute {
		return dimension.attribute
	}

	public var distinctRightParameters: Parameters {
		return Parameters(item: item, attribute: dimension.attribute, multiplier: multiplier, constant: constant)
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
