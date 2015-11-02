//
//  YAxisExpression.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Y-Axis Expression

public struct YAxisExpression<Constant: ConstantType>: DistinctExpressionType {
	private let lhs: YAxisAnchor<NoConstant>
	private let relation: Relation
	private let rhs: YAxisAnchor<Constant>
	private let priority: Priority?

	private init(lhs: YAxisAnchor<NoConstant>, relation: Relation, rhs: YAxisAnchor<Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> YAxisExpression {
		return YAxisExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftAnchor = lhs.anchor
		let rightAnchor = rhs.anchor
		let constant = rhs.constant.value ?? 0

		let constraint = constraintForRelation(relation, leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)

		if let priority = priority {
			constraint.priority = priority
		}

		return constraint
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		return [evaluateDistinct()]
	}
}

// ----------------------------------------------------------------------------
// MARK: - X-Axis Anchor

public struct YAxisAnchor<Constant: ConstantType> {
	private let anchor: NSLayoutYAxisAnchor
	public let constant: Constant

	internal init(anchor: NSLayoutYAxisAnchor, constant: Constant) {
		self.anchor = anchor
		self.constant = constant
	}

	private func updateConstant<NextConstant: ConstantType>(constant: NextConstant) -> YAxisAnchor<NextConstant> {
		return YAxisAnchor<NextConstant>(anchor: anchor, constant: constant)
	}

	private var withoutModifiers: YAxisAnchor<NoConstant> {
		return YAxisAnchor<NoConstant>(anchor: anchor, constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: YAxisAnchor<UndefinedConstant>, constant: CGFloat) -> YAxisAnchor<ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: constant))
}

public func - (lhs: YAxisAnchor<UndefinedConstant>, constant: CGFloat) -> YAxisAnchor<ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: -constant))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Constant>(lhs: YAxisAnchor<UndefinedConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func == <Constant>(lhs: YAxisAnchor<NoConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= <Constant>(lhs: YAxisAnchor<UndefinedConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Constant>(lhs: YAxisAnchor<NoConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Constant>(lhs: YAxisAnchor<UndefinedConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Constant>(lhs: YAxisAnchor<NoConstant>, rhs: YAxisAnchor<Constant>) -> YAxisExpression<Constant> {
	return YAxisExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
