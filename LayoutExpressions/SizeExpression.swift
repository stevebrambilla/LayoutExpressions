//
//  SizeExpression.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// Supports constraining the size to another view:
//     subview.lexSize == sibling.lexSize
//     subview.lexSize >= sibling.lexSize
//     subview.lexSize <= sibling.lexSize
//
// With an optional offset:
//     subview.lexSize == sibling.lexSize + Size(width: 20.0, height: 20.0)
//
// Supports constraining the size to a CGSize:
//     subview.size == Offset(width: 320.0, height: 480.0)

// ----------------------------------------------------------------------------
// MARK: - Size Expression

public struct SizeExpression<Size: SizeType>: ExpressionType {
	private let lhs: SizeAnchor<NoSize>
	private let relation: Relation
	private let rhs: SizeAnchor<Size>
	private let priority: Priority?

	private init(lhs: SizeAnchor<NoSize>, relation: Relation, rhs: SizeAnchor<Size>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> SizeExpression {
		assert(priority.isValid)
		return SizeExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let size = rhs.size.value ?? LayoutExpressions.Size.zeroSize

		let widthConstraint = constraintForRelation(relation, leftAnchor: lhs.widthAnchor, rightAnchor: rhs.widthAnchor, constant: size.width)
		let heightConstraint = constraintForRelation(relation, leftAnchor: lhs.heightAnchor, rightAnchor: rhs.heightAnchor, constant: size.height)

		if let priority = priority {
			widthConstraint.priority = priority
			heightConstraint.priority = priority
		}

		return [widthConstraint, heightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Constant Size Expression

public struct ConstantSizeExpression: ExpressionType {
	private let lhs: SizeAnchor<NoSize>
	private let relation: Relation
	private let size: Size
	private let priority: Priority?

	private init(lhs: SizeAnchor<NoSize>, relation: Relation, size: Size, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.size = size
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> ConstantSizeExpression {
		assert(priority.isValid)
		return ConstantSizeExpression(lhs: lhs, relation: relation, size: size, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let widthConstraint = constraintForRelation(relation, leftDimension: lhs.widthAnchor, constant: size.width)
		let heightConstraint = constraintForRelation(relation, leftDimension: lhs.heightAnchor, constant: size.height)

		if let priority = priority {
			widthConstraint.priority = priority
			heightConstraint.priority = priority
		}

		return [widthConstraint, heightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Size Anchor

public struct SizeAnchor<Size: SizeType> {
	private let widthAnchor: NSLayoutDimension
	private let heightAnchor: NSLayoutDimension
	public let size: Size

	internal init(widthAnchor: NSLayoutDimension, heightAnchor: NSLayoutDimension, size: Size) {
		self.widthAnchor = widthAnchor
		self.heightAnchor = heightAnchor
		self.size = size
	}

	private func updateSize<NextSize: SizeType>(size: NextSize) -> SizeAnchor<NextSize> {
		return SizeAnchor<NextSize>(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: size)
	}

	private var withoutModifiers: SizeAnchor<NoSize> {
		return SizeAnchor<NoSize>(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: NoSize())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: SizeAnchor<UndefinedSize>, size: Size) -> SizeAnchor<ValueSize> {
	return lhs.updateSize(ValueSize(value: size))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func == <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func <= <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Offset>(lhs: SizeAnchor<NoSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Offset>(lhs: SizeAnchor<UndefinedSize>, rhs: SizeAnchor<Offset>) -> SizeExpression<Offset> {
	return SizeExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func == (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs, relation: .Equal, size: rhs)
}

public func == (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .Equal, size: rhs)
}

public func <= (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs, relation: .LessThanOrEqual, size: rhs)
}

public func <= (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, size: rhs)
}

public func >= (lhs: SizeAnchor<NoSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs, relation: .GreaterThanOrEqual, size: rhs)
}

public func >= (lhs: SizeAnchor<UndefinedSize>, rhs: Size) -> ConstantSizeExpression {
	return ConstantSizeExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, size: rhs)
}
