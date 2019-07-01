//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// Supports constraining the size to another view:
//     subview.anchors.size == sibling.anchors.size
//     subview.anchors.size >= sibling.anchors.size
//     subview.anchors.size <= sibling.anchors.size
//
// With an optional offset:
//     subview.anchors.size == sibling.anchors.size + Size(width: 20.0, height: 20.0)
//
// Supports constraining the size to a CGSize:
//     subview.anchors.size == Offset(width: 320.0, height: 480.0)

// ----------------------------------------------------------------------------
// MARK: - Size Expression

public struct SizeExpression<Size: SizeProtocol>: ExpressionProtocol {
	fileprivate let lhs: SizeAnchor<NoSize>
	fileprivate let relation: Relation
	fileprivate let rhs: SizeAnchor<Size>
	fileprivate let priority: Priority?

	fileprivate init(lhs: SizeAnchor<NoSize>, relation: Relation, rhs: SizeAnchor<Size>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func update(priority: Priority) -> SizeExpression {
		assert(priority.isValid)
		return SizeExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let size = rhs.size.value ?? LayoutExpressions.Size.zeroSize

		let widthConstraint = DimensionConstraints.constraintForRelation(relation: relation, lhsDimension: lhs.widthAnchor, rhsDimension: rhs.widthAnchor, multiplier: 1.0, constant: size.width)
		let heightConstraint = DimensionConstraints.constraintForRelation(relation: relation, lhsDimension: lhs.heightAnchor, rhsDimension: rhs.heightAnchor, multiplier: 1.0, constant: size.height)

		if let priority = priority {
			widthConstraint.priority = priority.layoutPriority
			heightConstraint.priority = priority.layoutPriority
		}

		return [widthConstraint, heightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Constant Size Expression

public struct ConstantSizeExpression: ExpressionProtocol {
	fileprivate let lhs: SizeAnchor<NoSize>
	fileprivate let relation: Relation
	fileprivate let size: Size
	fileprivate let priority: Priority?

	fileprivate init(lhs: SizeAnchor<NoSize>, relation: Relation, size: Size, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.size = size
		self.priority = priority
	}

	public func update(priority: Priority) -> ConstantSizeExpression {
		assert(priority.isValid)
		return ConstantSizeExpression(lhs: lhs, relation: relation, size: size, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let widthConstraint = DimensionConstraints.constraintForRelation(relation: relation, lhsDimension: lhs.widthAnchor, constant: size.width)
		let heightConstraint = DimensionConstraints.constraintForRelation(relation: relation, lhsDimension: lhs.heightAnchor, constant: size.height)

		if let priority = priority {
			widthConstraint.priority = priority.layoutPriority
			heightConstraint.priority = priority.layoutPriority
		}

		return [widthConstraint, heightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Size Anchor

public struct SizeAnchor<Size: SizeProtocol> {
	fileprivate let widthAnchor: NSLayoutDimension
	fileprivate let heightAnchor: NSLayoutDimension
	public let size: Size

	internal init(widthAnchor: NSLayoutDimension, heightAnchor: NSLayoutDimension, size: Size) {
		self.widthAnchor = widthAnchor
		self.heightAnchor = heightAnchor
		self.size = size
	}

	fileprivate func update<NextSize>(size: NextSize) -> SizeAnchor<NextSize> {
		SizeAnchor<NextSize>(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: size)
	}

	fileprivate var withoutModifiers: SizeAnchor<NoSize> {
		SizeAnchor<NoSize>(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: NoSize())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: SizeAnchor<UndefinedSize>, size: Size) -> SizeAnchor<ValueSize> {
	lhs.update(size: ValueSize(value: size))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func <= <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	SizeExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}

public func == (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs, relation: .equal, size: rhs)
}

public func == (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .equal, size: rhs)
}

public func <= (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs, relation: .lessThanOrEqual, size: rhs)
}

public func <= (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, size: rhs)
}

public func >= (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs, relation: .greaterThanOrEqual, size: rhs)
}

public func >= (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, size: rhs)
}
