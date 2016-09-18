//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

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
	fileprivate let lhs: EdgesAnchor<NoInsets>
	fileprivate let relation: Relation
	fileprivate let rhs: EdgesAnchor<Insets>
	fileprivate let priority: Priority?

	fileprivate init(lhs: EdgesAnchor<NoInsets>, relation: Relation, rhs: EdgesAnchor<Insets>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func update(priority: Priority) -> EdgesExpression {
		assert(priority.isValid)
		return EdgesExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let insets = rhs.insets.value ?? LayoutExpressions.Insets.zeroInsets

		let topConstraint = AnchorConstraints.constraintForRelation(relation, leftAnchor: lhs.topAnchor, rightAnchor: rhs.topAnchor, constant: insets.top)
		let leftConstraint = AnchorConstraints.constraintForRelation(relation, leftAnchor: lhs.leftAnchor, rightAnchor: rhs.leftAnchor, constant: insets.left)
		let bottomConstraint = AnchorConstraints.constraintForRelation(relation, leftAnchor: lhs.bottomAnchor, rightAnchor: rhs.bottomAnchor, constant: -insets.bottom)
		let rightConstraint = AnchorConstraints.constraintForRelation(relation, leftAnchor: lhs.rightAnchor, rightAnchor: rhs.rightAnchor, constant: -insets.right)

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
	fileprivate let topAnchor: NSLayoutYAxisAnchor
	fileprivate let leftAnchor: NSLayoutXAxisAnchor
	fileprivate let bottomAnchor: NSLayoutYAxisAnchor
	fileprivate let rightAnchor: NSLayoutXAxisAnchor
	public let insets: Insets

	internal init(topAnchor: NSLayoutYAxisAnchor, leftAnchor: NSLayoutXAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor, rightAnchor: NSLayoutXAxisAnchor, insets: Insets) {
		self.topAnchor = topAnchor
		self.leftAnchor = leftAnchor
		self.bottomAnchor = bottomAnchor
		self.rightAnchor = rightAnchor
		self.insets = insets
	}

	fileprivate func updateInsets<NextInsets: InsetsType>(_ insets: NextInsets) -> EdgesAnchor<NextInsets> {
		return EdgesAnchor<NextInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: insets)
	}

	fileprivate var withoutModifiers: EdgesAnchor<NoInsets> {
		return EdgesAnchor<NoInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: NoInsets())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

// Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, insets: Insets) -> EdgesAnchor<ValueInsets> {
	return lhs.updateInsets(ValueInsets(value: insets))
}

// CGFloat Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, inset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: inset, left: inset, bottom: inset, right: inset)
	return lhs.updateInsets(ValueInsets(value: insets))
}

public func + (lhs: EdgesAnchor<UndefinedInsets>, outset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: -outset, left: -outset, bottom: -outset, right: -outset)
	return lhs.updateInsets(ValueInsets(value: insets))
}

// Int Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, inset: Int) -> EdgesAnchor<ValueInsets> {
	return lhs - CGFloat(inset)
}

public func + (lhs: EdgesAnchor<UndefinedInsets>, outset: Int) -> EdgesAnchor<ValueInsets> {
	return lhs + CGFloat(outset)
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	return EdgesExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}
