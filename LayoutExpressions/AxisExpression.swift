//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Axis

public protocol AxisType {
	associatedtype AnchorType: AnyObject
	var anchor: NSLayoutAnchor<AnchorType> { get }
}

public struct XAxis: AxisType {
	public let anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
	internal init(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
		self.anchor = anchor
	}
}

public struct YAxis: AxisType {
	public let anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
	internal init(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>) {
		self.anchor = anchor
	}
}

// ----------------------------------------------------------------------------
// MARK: - Axis Expression

public struct AxisExpression<Axis: AxisType, Constant: ConstantType>: DistinctExpressionType {
	fileprivate let lhs: AxisAnchor<Axis, NoConstant>
	fileprivate let relation: Relation
	fileprivate let rhs: AxisAnchor<Axis, Constant>
	fileprivate let priority: Priority?

	fileprivate init(lhs: AxisAnchor<Axis, NoConstant>, relation: Relation, rhs: AxisAnchor<Axis, Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func update(priority: Priority) -> AxisExpression {
		assert(priority.isValid)
		return AxisExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftAnchor = lhs.anchor
		let rightAnchor = rhs.anchor
		let constant = rhs.constant.value ?? 0

		let constraint = AnchorConstraints.constraintForRelation(relation: relation, leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)

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
// MARK: - Axis Anchor

public struct AxisAnchor<Axis: AxisType, Constant: ConstantType> {
	fileprivate let axis: Axis
	public let constant: Constant

	internal init(axis: Axis, constant: Constant) {
		self.axis = axis
		self.constant = constant
	}

	fileprivate var anchor: NSLayoutAnchor<Axis.AnchorType> {
		return axis.anchor
	}

	fileprivate func update<NextConstant: ConstantType>(constant: NextConstant) -> AxisAnchor<Axis, NextConstant> {
		return AxisAnchor<Axis, NextConstant>(axis: axis, constant: constant)
	}

	fileprivate var withoutModifiers: AxisAnchor<Axis, NoConstant> {
		return AxisAnchor<Axis, NoConstant>(axis: axis, constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

// CGFloat Constants

public func + <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	return lhs.update(constant: ValueConstant(value: constant))
}

public func - <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	return lhs.update(constant: ValueConstant(value: -constant))
}

// Int Constants

public func + <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: Int) -> AxisAnchor<Axis, ValueConstant> {
	return lhs + CGFloat(constant)
}

public func - <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: Int) -> AxisAnchor<Axis, ValueConstant> {
	return lhs - CGFloat(constant)
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}
