//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// Supports pinning the center to another view:
// 		subview.anchors.center == container.anchors.center
//
// With an optional offset:
// 		subview.anchors.center == container.anchors.center + Offset(horizontal: 0.0, vertical: -10.0)

// ----------------------------------------------------------------------------
// MARK: - Center Expression

public struct CenterExpression<Offset: OffsetProtocol>: ExpressionProtocol {
	fileprivate let lhs: CenterAnchor<NoOffset>
	fileprivate let relation: Relation
	fileprivate let rhs: CenterAnchor<Offset>
	fileprivate let priority: Priority?

	fileprivate init(lhs: CenterAnchor<NoOffset>, relation: Relation, rhs: CenterAnchor<Offset>, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	public func update(priority: Priority) -> CenterExpression {
		assert(priority.isValid)
		return CenterExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	public func evaluateAll() -> [NSLayoutConstraint] {
		let offset = rhs.offset.value ?? LayoutExpressions.Offset.zeroOffset

		let xConstraint = AnchorConstraints.constraintForRelation(relation: relation, leftAnchor: lhs.centerXAnchor, rightAnchor: rhs.centerXAnchor, constant: offset.horizontal)
		let yConstraint = AnchorConstraints.constraintForRelation(relation: relation, leftAnchor: lhs.centerYAnchor, rightAnchor: rhs.centerYAnchor, constant: offset.vertical)

		if let priority = priority {
			xConstraint.priority = priority.layoutPriority
			yConstraint.priority = priority.layoutPriority
		}

		return [xConstraint, yConstraint]
	}
}

// ----------------------------------------------------------------------------
// MARK: - Center Anchor

public struct CenterAnchor<Offset: OffsetProtocol> {
	fileprivate let centerXAnchor: NSLayoutXAxisAnchor
	fileprivate let centerYAnchor: NSLayoutYAxisAnchor
	public let offset: Offset

	internal init(centerXAnchor: NSLayoutXAxisAnchor, centerYAnchor: NSLayoutYAxisAnchor, offset: Offset) {
		self.centerXAnchor = centerXAnchor
		self.centerYAnchor = centerYAnchor
		self.offset = offset
	}

	fileprivate func updateOffset<NextOffset>(_ offset: NextOffset) -> CenterAnchor<NextOffset> {
		return CenterAnchor<NextOffset>(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: offset)
	}

	fileprivate var withoutModifiers: CenterAnchor<NoOffset> {
		return CenterAnchor<NoOffset>(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: NoOffset())
	}
}

// ----------------------------------------------------------------------------
// MARK: - Arithmetic Operators

public func + (lhs: CenterAnchor<UndefinedOffset>, offset: Offset) -> CenterAnchor<ValueOffset> {
	return lhs.updateOffset(ValueOffset(value: offset))
}

// ----------------------------------------------------------------------------
// MARK: - Comparison Operators

public func == <Offset>(lhs: CenterAnchor<NoOffset>, rhs: CenterAnchor<Offset>) -> CenterExpression<Offset> {
	return CenterExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Offset>(lhs: CenterAnchor<UndefinedOffset>, rhs: CenterAnchor<Offset>) -> CenterExpression<Offset> {
	return CenterExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}
