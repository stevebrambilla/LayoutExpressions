//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning the center to another view:
// 		subview.center == container.center
//
// With an optional offset:
// 		subview.center == container.center + (horizontal: 0.0, vertical: -10.0)

public struct CenterArgument: LeftArgument, RightArgument {
	private let item: AnyObject
	private let offset: PointOffset?

	internal init(item: AnyObject, offset: PointOffset? = nil) {
		self.item = item
		self.offset = offset
	}

	private func updateOffset(offset: PointOffset) -> CenterArgument {
		return CenterArgument(item: item, offset: offset)
	}

	public var leftItem: AnyObject {
		return item
	}

	public var leftAttributes: [NSLayoutAttribute] {
		return [.CenterX, .CenterY]
	}

	public func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters {
		switch attribute {
		case .CenterX:
			return Parameters(item: item, attribute: .CenterX, multiplier: nil, constant: offset?.horizontal)

		case .CenterY:
			return Parameters(item: item, attribute: .CenterY, multiplier: nil, constant: offset?.vertical)

		default:
			assert(false, "Called CenterArgument with an invalid attribute.")
			return Parameters.noOp
		}
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Shorthand Structs

public struct PointOffset {
	public var horizontal: CGFloat
	public var vertical: CGFloat

	public init(horizontal: CGFloat, vertical: CGFloat) {
		self.horizontal = horizontal
		self.vertical = vertical
	}

	public init(_ offset: UIOffset) {
		self.init(horizontal: offset.horizontal, vertical: offset.vertical)
	}

	public init(_ point: CGPoint) {
		self.init(horizontal: point.x, vertical: point.y)
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: CenterArgument, offset: PointOffset) -> CenterArgument {
	return lhs.updateOffset(offset)
}

// ------------------------------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == (lhs: CenterArgument, rhs: CenterArgument) -> Expression<CenterArgument, CenterArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}
