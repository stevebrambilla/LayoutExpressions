//
//  CenterExpression.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// Supports pinning the center to another view:
// 		subview.lexCenter == container.lexCenter
//
// With an optional offset:
// 		subview.center == container.lexCenter + Offset(horizontal: 0.0, vertical: -10.0)

// ----------------------------------------------------------------------------
// MARK: - Center Expression

public struct CenterExpression<Offset: OffsetType>: ExpressionType {
	private let lhs: CenterAnchor<NoOffset>
	private let relation: Relation
	private let rhs: CenterAnchor<Offset>
	private let priority: Priority?

	private init(lhs: CenterAnchor<NoOffset>, relation: Relation, rhs: CenterAnchor<Offset>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> CenterExpression {
		assert(priority.isValid)
		return CenterExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let offset = rhs.offset.value ?? LayoutExpressions.Offset.zeroOffset

		let xConstraint = constraintForRelation(relation, leftAnchor: lhs.centerXAnchor, rightAnchor: rhs.centerXAnchor, constant: offset.horizontal)
		let yConstraint = constraintForRelation(relation, leftAnchor: lhs.centerYAnchor, rightAnchor: rhs.centerYAnchor, constant: offset.vertical)

		if let priority = priority {
			xConstraint.priority = priority
			yConstraint.priority = priority
		}

		return [xConstraint, yConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Center Anchor

public struct CenterAnchor<Offset: OffsetType> {
	private let centerXAnchor: NSLayoutXAxisAnchor
	private let centerYAnchor: NSLayoutYAxisAnchor
	public let offset: Offset

	internal init(centerXAnchor: NSLayoutXAxisAnchor, centerYAnchor: NSLayoutYAxisAnchor, offset: Offset) {
		self.centerXAnchor = centerXAnchor
		self.centerYAnchor = centerYAnchor
		self.offset = offset
	}

	private func updateOffset<NextOffset: OffsetType>(offset: NextOffset) -> CenterAnchor<NextOffset> {
		return CenterAnchor<NextOffset>(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: offset)
	}

	private var withoutModifiers: CenterAnchor<NoOffset> {
		return CenterAnchor<NoOffset>(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: NoOffset())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: CenterAnchor<UndefinedOffset>, offset: Offset) -> CenterAnchor<ValueOffset> {
	return lhs.updateOffset(ValueOffset(value: offset))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Offset>(lhs: CenterAnchor<NoOffset>, rhs: CenterAnchor<Offset>) -> CenterExpression<Offset> {
	return CenterExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func == <Offset>(lhs: CenterAnchor<UndefinedOffset>, rhs: CenterAnchor<Offset>) -> CenterExpression<Offset> {
	return CenterExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}
