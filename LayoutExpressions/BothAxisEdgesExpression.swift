//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if os(macOS)
import AppKit
#else
import UIKit
#endif

// Supports pinning all edges:
// 		subview.anchors.edges == container.anchors.edges
//
// Supports insets using the '-' operator with a Insets struct:
//     	subview.anchors.edges == container.anchors.edges - Insets(top: 10.0, left: 5.0, bottom: 5.0, right: 10.0)
//
// Or inset all edges equally using '-' with a Double:
// 		subview.anchors.edges == container.anchors.edges - 10.0
//
// The '+' operator defines outsets:
// 		subview.anchors.edges == container.anchors.edges + 10.0

// ----------------------------------------------------------------------------
// MARK: - Edges Expression

public struct EdgesExpression<Insets: InsetsProtocol>: ExpressionProtocol {
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

		let topConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.topAnchor, rhsAnchor: rhs.topAnchor, constant: insets.top)
		let leftConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.leftAnchor, rhsAnchor: rhs.leftAnchor, constant: insets.left)
		let bottomConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.bottomAnchor, rhsAnchor: rhs.bottomAnchor, constant: -insets.bottom)
		let rightConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.rightAnchor, rhsAnchor: rhs.rightAnchor, constant: -insets.right)

		if let priority = priority {
			topConstraint.priority = priority.layoutPriority
			leftConstraint.priority = priority.layoutPriority
			bottomConstraint.priority = priority.layoutPriority
			rightConstraint.priority = priority.layoutPriority
		}

		return [topConstraint, leftConstraint, bottomConstraint, rightConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Edges Anchor

public struct EdgesAnchor<Insets: InsetsProtocol> {
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

	fileprivate func update<NextInsets>(insets: NextInsets) -> EdgesAnchor<NextInsets> {
		EdgesAnchor<NextInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: insets)
	}

	fileprivate var withoutModifiers: EdgesAnchor<NoInsets> {
		EdgesAnchor<NoInsets>(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: NoInsets())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

// Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, insets: Insets) -> EdgesAnchor<ValueInsets> {
	lhs.update(insets: ValueInsets(value: insets))
}

// CGFloat Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, inset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: inset, left: inset, bottom: inset, right: inset)
	return lhs.update(insets: ValueInsets(value: insets))
}

public func + (lhs: EdgesAnchor<UndefinedInsets>, outset: CGFloat) -> EdgesAnchor<ValueInsets> {
	let insets = Insets(top: -outset, left: -outset, bottom: -outset, right: -outset)
	return lhs.update(insets: ValueInsets(value: insets))
}

// Int Insets

public func - (lhs: EdgesAnchor<UndefinedInsets>, inset: Int) -> EdgesAnchor<ValueInsets> {
	lhs - CGFloat(inset)
}

public func + (lhs: EdgesAnchor<UndefinedInsets>, outset: Int) -> EdgesAnchor<ValueInsets> {
	lhs + CGFloat(outset)
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<NoInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Insets>(lhs: EdgesAnchor<UndefinedInsets>, rhs: EdgesAnchor<Insets>) -> EdgesExpression<Insets> {
	EdgesExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}
