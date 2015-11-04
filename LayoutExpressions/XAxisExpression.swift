//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - X-Axis Expression

public struct XAxisExpression<Constant: ConstantType>: DistinctExpressionType {
	private let lhs: XAxisAnchor<NoConstant>
	private let relation: Relation
	private let rhs: XAxisAnchor<Constant>
	private let priority: Priority?

	private init(lhs: XAxisAnchor<NoConstant>, relation: Relation, rhs: XAxisAnchor<Constant>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> XAxisExpression {
		assert(priority.isValid)
		return XAxisExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
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
// MARK: - X-Axis Anchor

public struct XAxisAnchor<Constant: ConstantType> {
	private let anchor: NSLayoutXAxisAnchor
	public let constant: Constant

	internal init(anchor: NSLayoutXAxisAnchor, constant: Constant) {
		self.anchor = anchor
		self.constant = constant
	}

	private func updateConstant<NextConstant: ConstantType>(constant: NextConstant) -> XAxisAnchor<NextConstant> {
		return XAxisAnchor<NextConstant>(anchor: anchor, constant: constant)
	}

	private var withoutModifiers: XAxisAnchor<NoConstant> {
		return XAxisAnchor<NoConstant>(anchor: anchor, constant: NoConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: XAxisAnchor<UndefinedConstant>, constant: CGFloat) -> XAxisAnchor<ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: constant))
}

public func - (lhs: XAxisAnchor<UndefinedConstant>, constant: CGFloat) -> XAxisAnchor<ValueConstant> {
	return lhs.updateConstant(ValueConstant(value: -constant))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Constant>(lhs: XAxisAnchor<UndefinedConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func == <Constant>(lhs: XAxisAnchor<NoConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func <= <Constant>(lhs: XAxisAnchor<UndefinedConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Constant>(lhs: XAxisAnchor<NoConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Constant>(lhs: XAxisAnchor<UndefinedConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Constant>(lhs: XAxisAnchor<NoConstant>, rhs: XAxisAnchor<Constant>) -> XAxisExpression<Constant> {
	return XAxisExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}
