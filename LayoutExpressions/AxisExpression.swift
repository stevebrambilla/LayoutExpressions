//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#else
import UIKit
#endif

// MARK: - Axis

public protocol AxisProtocol {
	associatedtype AnchorType: AnyObject
	var anchor: NSLayoutAnchor<AnchorType> { get }
}

public struct XAxis: AxisProtocol {
	public let anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
	internal init(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
		self.anchor = anchor
	}
}

public struct YAxis: AxisProtocol {
	public let anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
	internal init(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>) {
		self.anchor = anchor
	}
}

// MARK: - Axis Expression

public struct AxisExpression<Axis: AxisProtocol, Constant: ConstantProtocol>: DistinctExpressionProtocol {
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

	public func evaluateDistinct() -> Constraint {
		let lhsAnchor = lhs.anchor
		let rhsAnchor = rhs.anchor
		let constant = rhs.constant.value ?? 0

		let constraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)

		if let priority = priority {
			constraint.priority = priority.layoutPriority
		}

		return constraint
	}

	public func evaluateAll() -> [Constraint] {
		return [evaluateDistinct()]
	}
}

// MARK: - Axis Anchor

public struct AxisAnchor<Axis: AxisProtocol, Constant: ConstantProtocol> {
	fileprivate let axis: Axis
	public let constant: Constant

	internal init(axis: Axis, constant: Constant) {
		self.axis = axis
		self.constant = constant
	}

	fileprivate var anchor: NSLayoutAnchor<Axis.AnchorType> {
		axis.anchor
	}

	fileprivate func update<NextConstant>(constant: NextConstant) -> AxisAnchor<Axis, NextConstant> {
		AxisAnchor<Axis, NextConstant>(axis: axis, constant: constant)
	}

	fileprivate var withoutModifiers: AxisAnchor<Axis, NoConstant> {
		AxisAnchor<Axis, NoConstant>(axis: axis, constant: NoConstant())
	}
}

// MARK: - Arithmetic Operators

// CGFloat Constants

public func + <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	lhs.update(constant: ValueConstant(value: constant))
}

public func - <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: CGFloat) -> AxisAnchor<Axis, ValueConstant> {
	lhs.update(constant: ValueConstant(value: -constant))
}

// Int Constants

public func + <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: Int) -> AxisAnchor<Axis, ValueConstant> {
	lhs + CGFloat(constant)
}

public func - <Axis>(lhs: AxisAnchor<Axis, UndefinedConstant>, constant: Int) -> AxisAnchor<Axis, ValueConstant> {
	lhs - CGFloat(constant)
}

// MARK: - Comparison Operators

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func == <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, UndefinedConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Axis, Constant>(lhs: AxisAnchor<Axis, NoConstant>, rhs: AxisAnchor<Axis, Constant>) -> AxisExpression<Axis, Constant> {
	AxisExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}
