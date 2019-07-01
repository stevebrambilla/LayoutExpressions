//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Dimension Expression

public struct DimensionExpression<Multiplier: MultiplierProtocol, Constant: ConstantProtocol>: DistinctExpressionProtocol {
	fileprivate let lhs: DimensionAnchor<NoMultiplier, NoConstant>
	fileprivate let relation: Relation
	fileprivate let rhs: DimensionAnchor<Multiplier, Constant>
	fileprivate let priority: Priority?

	fileprivate init(lhs: DimensionAnchor<NoMultiplier, NoConstant>, relation: Relation, rhs: DimensionAnchor<Multiplier, Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func update(priority: Priority) -> DimensionExpression {
		assert(priority.isValid)
		return DimensionExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftDimension = lhs.dimension
		let rightDimension = rhs.dimension
		let multiplier = rhs.multiplier.value ?? 1
		let constant = rhs.constant.value ?? 0

		let constraint = DimensionConstraints.constraintForRelation(relation: relation, leftDimension: leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)

		if let priority = priority {
			constraint.priority = priority.layoutPriority
		}

		return constraint
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		[evaluateDistinct()]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Constant Dimension Expression

public struct ConstantDimensionExpression: DistinctExpressionProtocol {
	fileprivate let lhs: DimensionAnchor<NoMultiplier, NoConstant>
	fileprivate let relation: Relation
	fileprivate let constant: ValueConstant
	fileprivate let priority: Priority?

	fileprivate init(lhs: DimensionAnchor<NoMultiplier, NoConstant>, relation: Relation, constant: ValueConstant, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.constant = constant
		self.priority = priority
	}

	public func update(priority: Priority) -> ConstantDimensionExpression {
		assert(priority.isValid)
		return ConstantDimensionExpression(lhs: lhs, relation: relation, constant: constant, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftDimension = lhs.dimension
		let constantValue = constant.value ?? 0

		let constraint = DimensionConstraints.constraintForRelation(relation: relation, leftDimension: leftDimension, constant: constantValue)

		if let priority = priority {
			constraint.priority = priority.layoutPriority
		}

		return constraint
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		[evaluateDistinct()]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Dimension Anchor

public struct DimensionAnchor<Multiplier: MultiplierProtocol, Constant: ConstantProtocol> {
	fileprivate let dimension: NSLayoutDimension
	public let multiplier: Multiplier
	public let constant: Constant

	internal init(dimension: NSLayoutDimension, multiplier: Multiplier, constant: Constant) {
		self.dimension = dimension
		self.multiplier = multiplier
		self.constant = constant
	}

	fileprivate func update<NextMultiplier>(multiplier: NextMultiplier) -> DimensionAnchor<NextMultiplier, Constant> {
		DimensionAnchor<NextMultiplier, Constant>(dimension: dimension, multiplier: multiplier, constant: constant)
	}

	fileprivate func update<NextConstant>(constant: NextConstant) -> DimensionAnchor<Multiplier, NextConstant> {
		DimensionAnchor<Multiplier, NextConstant>(dimension: dimension, multiplier: multiplier, constant: constant)
	}

	fileprivate var withoutModifiers: DimensionAnchor<NoMultiplier, NoConstant> {
		DimensionAnchor<NoMultiplier, NoConstant>(dimension: dimension, multiplier: NoMultiplier(), constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

// CGFloat Constants and Multipliers

public func + <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: CGFloat) -> DimensionAnchor<Multiplier, ValueConstant> {
	lhs.update(constant: ValueConstant(value: constant))
}

public func - <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: CGFloat) -> DimensionAnchor<Multiplier, ValueConstant> {
	lhs.update(constant: ValueConstant(value: -constant))
}

public func * <Constant>(lhs: DimensionAnchor<UndefinedMultiplier, Constant>, multiplier: CGFloat) -> DimensionAnchor<ValueMultiplier, Constant> {
	lhs.update(multiplier: ValueMultiplier(value: multiplier))
}

public func * <Constant>(multiplier: CGFloat, rhs: DimensionAnchor<UndefinedMultiplier, Constant>) -> DimensionAnchor<ValueMultiplier, Constant> {
	rhs.update(multiplier: ValueMultiplier(value: multiplier))
}

// Int Constants and Multipliers

public func + <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: Int) -> DimensionAnchor<Multiplier, ValueConstant> {
	lhs + CGFloat(constant)
}

public func - <Multiplier>(lhs: DimensionAnchor<Multiplier, UndefinedConstant>, constant: Int) -> DimensionAnchor<Multiplier, ValueConstant> {
	lhs - CGFloat(constant)
}

public func * <Constant>(lhs: DimensionAnchor<UndefinedMultiplier, Constant>, multiplier: Int) -> DimensionAnchor<ValueMultiplier, Constant> {
	lhs * CGFloat(multiplier)
}

public func * <Constant>(multiplier: Int, rhs: DimensionAnchor<UndefinedMultiplier, Constant>) -> DimensionAnchor<ValueMultiplier, Constant> {
	CGFloat(multiplier) * rhs
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func == <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func <= <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Multiplier, Constant>(lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Multiplier, Constant>(lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: DimensionAnchor<Multiplier, Constant>) -> DimensionExpression<Multiplier, Constant> {
	DimensionExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

// ----------------------------------------------------------------------------
// MARK: - CGFloat Constant Comparison Operators

public func == (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .equal, constant: ValueConstant(value: rhs))
}

public func == (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs, relation: .equal, constant: ValueConstant(value: rhs))
}

public func <= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, constant: ValueConstant(value: rhs))
}

public func <= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs, relation: .lessThanOrEqual, constant: ValueConstant(value: rhs))
}

public func >= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, constant: ValueConstant(value: rhs))
}

public func >= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: CGFloat) -> ConstantDimensionExpression {
	ConstantDimensionExpression(lhs: lhs, relation: .greaterThanOrEqual, constant: ValueConstant(value: rhs))
}

// ----------------------------------------------------------------------------
// MARK: - Int Constant Comparison Operators

public func == (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs == CGFloat(rhs)
}

public func == (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs == CGFloat(rhs)
}

public func <= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs <= CGFloat(rhs)
}

public func <= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs <= CGFloat(rhs)
}

public func >= (lhs: DimensionAnchor<UndefinedMultiplier, UndefinedConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs >= CGFloat(rhs)
}

public func >= (lhs: DimensionAnchor<NoMultiplier, NoConstant>, rhs: Int) -> ConstantDimensionExpression {
	lhs >= CGFloat(rhs)
}
