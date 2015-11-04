//
//  DimensionExpression.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Dimension Expression

public struct DimensionExpression<Multiplier: MultiplierType, Constant: ConstantType>: DistinctExpressionType {
	private let lhs: DimensionAnchor<NoMultiplier, NoConstant>
	private let relation: Relation
	private let rhs: DimensionAnchor<Multiplier, Constant>
	private let priority: Priority?

	private init(lhs: DimensionAnchor<NoMultiplier, NoConstant>, relation: Relation, rhs: DimensionAnchor<Multiplier, Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> DimensionExpression {
		assert(priority.isValid)
		return DimensionExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftDimension = lhs.dimension
		let rightDimension = rhs.dimension
		let multiplier = rhs.multiplier.value ?? 1
		let constant = rhs.constant.value ?? 0

		let constraint = constraintForRelation(relation, leftDimension: leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)

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
// MARK: - Constant Dimension Expression

public struct ConstantDimensionExpression: DistinctExpressionType {
	private let lhs: DimensionAnchor<NoMultiplier, NoConstant>
	private let relation: Relation
	private let constant: ValueConstant
	private let priority: Priority?

	private init(lhs: DimensionAnchor<NoMultiplier, NoConstant>, relation: Relation, constant: ValueConstant, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.constant = constant
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> ConstantDimensionExpression {
		assert(priority.isValid)
		return ConstantDimensionExpression(lhs: lhs, relation: relation, constant: constant, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftDimension = lhs.dimension
		let constantValue = constant.value ?? 0

		let constraint = constraintForRelation(relation, leftDimension: leftDimension, constant: constantValue)

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
// MARK: - Dimension Anchor

public struct DimensionAnchor<Multiplier: MultiplierType, Constant: ConstantType> {
	private let dimension: NSLayoutDimension
	public let multiplier: Multiplier
	public let constant: Constant

	internal init(dimension: NSLayoutDimension, multiplier: Multiplier, constant: Constant) {
		self.dimension = dimension
		self.multiplier = multiplier
		self.constant = constant
	}

	private func updateMultiplier<NextMultiplier: MultiplierType>(multiplier: NextMultiplier) -> DimensionAnchor<NextMultiplier, Constant> {
		return DimensionAnchor<NextMultiplier, Constant>(dimension: dimension, multiplier: multiplier, constant: constant)
	}

	private func updateConstant<NextConstant: ConstantType>(constant: NextConstant) -> DimensionAnchor<Multiplier, NextConstant> {
		return DimensionAnchor<Multiplier, NextConstant>(dimension: dimension, multiplier: multiplier, constant: constant)
	}

	private var withoutModifiers: DimensionAnchor<NoMultiplier, NoConstant> {
		return DimensionAnchor<NoMultiplier, NoConstant>(dimension: dimension, multiplier: NoMultiplier(), constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: CGFloat) -> DimensionAnchor<Multiplier, ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: constant))
}

public func - <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: CGFloat) -> DimensionAnchor<Multiplier, ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: -constant))
}

public func * <Constant>(lhs: DimensionAnchor<UndefinedMultiplier, Constant>, multiplier: CGFloat) -> DimensionAnchor<ValueMultiplier, Constant> {
	return lhs.updateMultiplier(ValueMultiplier(value: multiplier))
}

public func * <Constant>(multiplier: CGFloat, rhs: DimensionAnchor<UndefinedMultiplier, Constant>) -> DimensionAnchor<ValueMultiplier, Constant> {
	return rhs.updateMultiplier(ValueMultiplier(value: multiplier))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func == <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	return DimensionExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

// ----------------------------------------------------------------------------
// MARK: - Constant Comparison Operators

public func == (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .Equal, constant: ValueConstant(value: rhs))
}

public func == (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs, relation: .Equal, constant: ValueConstant(value: rhs))
}

public func <= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, constant: ValueConstant(value: rhs))
}

public func <= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs, relation: .LessThanOrEqual, constant: ValueConstant(value: rhs))
}

public func >= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, constant: ValueConstant(value: rhs))
}

public func >= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	return ConstantDimensionExpression(lhs: lhs, relation: .GreaterThanOrEqual, constant: ValueConstant(value: rhs))
}
