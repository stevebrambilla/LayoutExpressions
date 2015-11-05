//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Axis

public protocol AxisType {
	var anchor: NSLayoutAnchor { get }
}

public struct XAxis: AxisType {
	public let anchor: NSLayoutAnchor
	internal init(anchor: NSLayoutXAxisAnchor) {
		self.anchor = anchor
	}
}

public struct YAxis: AxisType {
	public let anchor: NSLayoutAnchor
	internal init(anchor: NSLayoutYAxisAnchor) {
		self.anchor = anchor
	}
}

// ----------------------------------------------------------------------------
// MARK: - Axis Expression

public struct AxisExpression<Axis: AxisType, Constant: ConstantType>: DistinctExpressionType {
	private let lhs: AxisAnchor<Axis, NoConstant>
	private let relation: Relation
	private let rhs: AxisAnchor<Axis, Constant>
	private let priority: Priority?

	private init(lhs: AxisAnchor<Axis, NoConstant>, relation: Relation, rhs: AxisAnchor<Axis, Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> AxisExpression {
		assert(priority.isValid)
		return AxisExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateDistinct() -> NSLayoutConstraint {
		let leftAnchor = lhs.anchor
		let rightAnchor = rhs.anchor
		let constant = rhs.constant.value ?? 0

		let constraint = AnchorConstraints.constraintForRelation(relation, leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)

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
	private let axis: Axis
	public let constant: Constant

	internal init(axis: Axis, constant: Constant) {
		self.axis = axis
		self.constant = constant
	}

	private var anchor: NSLayoutAnchor {
		return axis.anchor
	}

	private func updateConstant<NextConstant: ConstantType>(constant: NextConstant) -> AxisAnchor<Axis, NextConstant> {
		return AxisAnchor<Axis, NextConstant>(axis: axis, constant: constant)
	}

	private var withoutModifiers: AxisAnchor<Axis, NoConstant> {
		return AxisAnchor<Axis, NoConstant>(axis: axis, constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: constant))
}

public func - <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: -constant))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	return AxisExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
