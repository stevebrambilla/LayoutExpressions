//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning the center to another view:
// 		subview.center == container.center
//
// With an optional offset:
// 		subview.center == container.center + (horizontal: 0.0, vertical: -10.0)

// MARK: - Shorthand Structs

public struct PointOffset {
	var horizontal: CGFloat
	var vertical: CGFloat

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

// MARK: - Arguments

public class CenterArgument: LeftHandSideArgument, RightHandSideArgument {
	public let item: AnyObject
	private let offset: PointOffset?

	init(item: AnyObject, offset: PointOffset? = nil) {
		self.item = item
		self.offset = offset
	}

	func updateOffset(offset: PointOffset) -> CenterArgument {
		return CenterArgument(item: item, offset: offset)
	}

	// LeftHandSideArgument
	public var attributes: [NSLayoutAttribute] {
		return [ .CenterX, .CenterY ]
	}

	// RightHandSideArgument
	public func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		switch leftAttribute {
		case .CenterX:
			return (item: item, attribute: .CenterX, multiplier: nil, constant: offset?.horizontal)
		case .CenterY:
			return (item: item, attribute: .CenterY, multiplier: nil, constant: offset?.vertical)
		default:
			assert(false, "Called CenterArgument with an invalid left attribute.")
			return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: nil)
		}
	}
}

// MARK: - Arithmetic Operators

public func +(lhs: CenterArgument, offset: PointOffset) -> CenterArgument {
	return lhs.updateOffset(offset)
}

// MARK: - Comparison Operators

public func ==(lhs: CenterArgument, rhs: CenterArgument) -> Expression<CenterArgument, CenterArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}
