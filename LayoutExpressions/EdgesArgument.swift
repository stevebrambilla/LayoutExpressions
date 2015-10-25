//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning all edges:
// 		subview.allEdges == container.allEdges
//
// Supports insets using the '-' operator with a EdgeInsets struct:
//     	subview.allEdges == container.allEdges - (top: 10.0, left: 5.0, bottom: 5.0, right: 10.0)
//
// Or inset all edges equally using '-' with a Double:
// 		subview.allEdges == container.allEdges - 10.0

public struct EdgesArgument: LeftArgument, RightArgument {
	private let item: AnyObject
	private let insets: EdgeInsets?

	internal init(item: AnyObject, insets: EdgeInsets? = nil) {
		self.item = item
		self.insets = insets
	}

	private func updateInsets(insets: EdgeInsets) -> EdgesArgument {
		return EdgesArgument(item: item, insets: insets)
	}

	public var leftItem: AnyObject {
		return item
	}

	public var leftAttributes: [NSLayoutAttribute] {
		return [.Top, .Left, .Bottom, .Right]
	}

	public func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters {
		switch attribute {
		case .Top:
			return Parameters(item: item, attribute: .Top, multiplier: nil, constant: insets?.top)

		case .Left:
			return Parameters(item: item, attribute: .Left, multiplier: nil, constant: insets?.left)

		case .Bottom:
			let bottomInset = insets.map { -$0.bottom }
			return Parameters(item: item, attribute: .Bottom, multiplier: nil, constant: bottomInset)

		case .Right:
			let rightInset = insets.map { -$0.right }
			return Parameters(item: item, attribute: .Right, multiplier: nil, constant: rightInset)

		default:
			assert(false, "Called EdgesArgument with an invalid attribute.")
			return Parameters.noOp
		}
	}
}

// ----------------------------------------------------------------------------
// MARK: - Shorthand Structs

public struct EdgeInsets {
	public let top: CGFloat
	public let left: CGFloat
	public let bottom: CGFloat
	public let right: CGFloat

	public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
		self.top = top
		self.left = left
		self.bottom = bottom
		self.right = right
	}

	public init(_ insets: UIEdgeInsets) {
		self.init(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func - (lhs: EdgesArgument, inset: CGFloat) -> EdgesArgument {
	let insets = EdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	return lhs.updateInsets(insets)
}

public func - (lhs: EdgesArgument, insets: EdgeInsets) -> EdgesArgument {
	return lhs.updateInsets(insets)
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == (lhs: EdgesArgument, rhs: EdgesArgument) -> Expression<EdgesArgument, EdgesArgument> {
	return Expression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= (lhs: EdgesArgument, rhs: EdgesArgument) -> Expression<EdgesArgument, EdgesArgument> {
	return Expression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= (lhs: EdgesArgument, rhs: EdgesArgument) -> Expression<EdgesArgument, EdgesArgument> {
	return Expression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
