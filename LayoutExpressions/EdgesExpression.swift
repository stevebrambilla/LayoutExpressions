//
//  EdgesExpression.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// Supports pinning all edges:
// 		subview.lexEdges == container.lexEdges
//
// Supports insets using the '-' operator with a Insets struct:
//     	subview.lexEdges == container.lexEdges - Insets(top: 10.0, left: 5.0, bottom: 5.0, right: 10.0)
//
// Or inset all edges equally using '-' with a Double:
// 		subview.lexEdges == container.lexEdges - 10.0
//
// The '+' operator defines outsets:
// 		subview.lexEdges == container.lexEdges + 10.0

// ----------------------------------------------------------------------------
// MARK: - Edges Expression

public struct EdgesExpression<Insets: InsetsType>: ExpressionType {
	private let lhs: EdgesAnchor<NoInsets>
	private let relation: Relation
	private let rhs: EdgesAnchor<Insets>
	private let priority: Priority?

	private init(lhs: EdgesAnchor<NoInsets>, relation: Relation, rhs: EdgesAnchor<Insets>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func updatePriority(priority: Priority) -> EdgesExpression {
		return EdgesExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let insets = rhs.insets.value ?? LayoutExpressions.Insets.zeroInsets

		let topConstraint = constraintForRelation(relation, leftAnchor: lhs.topAnchor, rightAnchor: rhs.topAnchor, constant: insets.top)
		let leftConstraint = constraintForRelation(relation, leftAnchor: lhs.leftAnchor, rightAnchor: rhs.leftAnchor, constant: insets.left)
		let bottomConstraint = constraintForRelation(relation, leftAnchor: lhs.bottomAnchor, rightAnchor: rhs.bottomAnchor, constant: -insets.bottom)
		let rightConstraint = constraintForRelation(relation, leftAnchor: lhs.rightAnchor, rightAnchor: rhs.rightAnchor, constant: -insets.right)

		if let priority = priority {
			topConstraint.priority = priority
			leftConstraint.priority = priority
			bottomConstraint.priority = priority
			rightConstraint.priority = priority
		}

		return [topConstraint, leftConstraint, bottomConstraint, rightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Edges Anchor

public struct EdgesAnchor<Insets: InsetsType> {
	private let topAnchor: NSLayoutYAxisAnchor
	private let leftAnchor: NSLayoutXAxisAnchor
	private let bottomAnchor: NSLayoutYAxisAnchor
	private let rightAnchor: NSLayoutXAxisAnchor
	public let insets: Insets

	internal init(topAnchor: NSLayoutYAxisAnchor, leftAnchor: NSLayoutXAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor, rightAnchor: NSLayoutXAxisAnchor, insets: Insets) {
		self.topAnchor = topAnchor
		self.leftAnchor = leftAnchor
		self.bottomAnchor = bottomAnchor
		self.rightAnchor = rightAnchor
		self.insets = insets
	}

	private func updateInsets<NextInsets: InsetsType>(insets: NextInsets) -> EdgesAnchor<NextInsets> {
		return EdgesAnchor<NextInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: insets)
	}

	private var withoutModifiers: EdgesAnchor<NoInsets> {
		return EdgesAnchor<NoInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: NoInsets())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func - (lhs: EdgesAnchor<UndefinedInsets>, inset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: inset, left: inset, bottom: inset, right: inset)
	return lhs.updateInsets(ValueInsets(value: insets))
}

public func - (lhs: EdgesAnchor<UndefinedInsets>, insets: Insets) -> EdgesAnchor<ValueInsets> {
	return lhs.updateInsets(ValueInsets(value: insets))
}

public func + (lhs: EdgesAnchor<UndefinedInsets>, outset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: -outset, left: -outset, bottom: -outset, right: -outset)
	return lhs.updateInsets(ValueInsets(value: insets))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .Equal, rhs: rhs)
}

public func == <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .Equal, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .LessThanOrEqual, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .LessThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .GreaterThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .GreaterThanOrEqual, rhs: rhs)
}
