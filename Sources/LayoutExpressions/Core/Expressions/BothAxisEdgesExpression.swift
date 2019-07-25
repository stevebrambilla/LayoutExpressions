//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

// Supports pinning all edges:
//      subview.anchors.allEdges == container.anchors.allEdges
//
// Supports insets using the '-' operator:
//      subview.anchors.allEdges == container.anchors.allEdges - 10
//
// The '+' operator defines outsets:
//      subview.anchors.allEdges == container.anchors.allEdges + 10

// MARK: - Both Axis Edges Expression

public struct BothAxisEdgesExpression<Inset: ConstantProtocol>: ExpressionProtocol {
    fileprivate let lhs: BothAxisEdgesAnchor<NoConstant>
    fileprivate let relation: Relation
    fileprivate let rhs: BothAxisEdgesAnchor<Inset>
    fileprivate let priority: Priority?

    fileprivate init(lhs: BothAxisEdgesAnchor<NoConstant>, relation: Relation, rhs: BothAxisEdgesAnchor<Inset>, priority: Priority? = nil) {
        self.lhs = lhs
        self.relation = relation
        self.rhs = rhs
        self.priority = priority
    }

    public func update(priority: Priority) -> BothAxisEdgesExpression {
        assert(priority.isValid)
        return BothAxisEdgesExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
    }

    public func evaluateAll() -> [Constraint] {
        let inset = rhs.inset.value ?? 0

        let top = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.topAnchor, rhsAnchor: rhs.topAnchor, constant: -inset)
        let bottom = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.bottomAnchor, rhsAnchor: rhs.bottomAnchor, constant: inset)

        let leading = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.leadingAnchor, rhsAnchor: rhs.leadingAnchor, constant: -inset)
        let trailing = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.trailingAnchor, rhsAnchor: rhs.trailingAnchor, constant: inset)

        if let priority = priority {
            top.priority = priority.layoutPriority
            bottom.priority = priority.layoutPriority
            leading.priority = priority.layoutPriority
            trailing.priority = priority.layoutPriority
        }

        return [top, bottom, leading, trailing]
    }
}

// MARK: - Edges Anchor

public struct BothAxisEdgesAnchor<Inset: ConstantProtocol> {
    fileprivate let topAnchor: NSLayoutYAxisAnchor
    fileprivate let bottomAnchor: NSLayoutYAxisAnchor
    fileprivate let leadingAnchor: NSLayoutXAxisAnchor
    fileprivate let trailingAnchor: NSLayoutXAxisAnchor
    public let inset: Inset

    internal init(top: NSLayoutYAxisAnchor, bottom: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, inset: Inset) {
        self.topAnchor = top
        self.bottomAnchor = bottom
        self.leadingAnchor = leading
        self.trailingAnchor = trailing
        self.inset = inset
    }

    fileprivate func update<NextInset>(inset: NextInset) -> BothAxisEdgesAnchor<NextInset> {
        BothAxisEdgesAnchor<NextInset>(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, inset: inset)
    }

    fileprivate var withoutModifiers: BothAxisEdgesAnchor<NoConstant> {
        BothAxisEdgesAnchor<NoConstant>(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, inset: NoConstant())
    }
}

// MARK: - Arithmetic Operators

// CGFloat Insets / Outsets

public func - (lhs: BothAxisEdgesAnchor<UndefinedConstant>, inset: CGFloat) -> BothAxisEdgesAnchor<ValueConstant> {
    return lhs.update(inset: ValueConstant(value: -inset))
}

public func + (lhs: BothAxisEdgesAnchor<UndefinedConstant>, outset: CGFloat) -> BothAxisEdgesAnchor<ValueConstant> {
    return lhs.update(inset: ValueConstant(value: outset))
}

// Int Insets / Outsets

public func - (lhs: BothAxisEdgesAnchor<UndefinedConstant>, inset: Int) -> BothAxisEdgesAnchor<ValueConstant> {
    lhs - CGFloat(inset)
}

public func + (lhs: BothAxisEdgesAnchor<UndefinedConstant>, outset: Int) -> BothAxisEdgesAnchor<ValueConstant> {
    lhs + CGFloat(outset)
}

// MARK: - Comparison Operators

public func == <Inset>(lhs: BothAxisEdgesAnchor<NoConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Inset>(lhs: BothAxisEdgesAnchor<UndefinedConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func <= <Inset>(lhs: BothAxisEdgesAnchor<NoConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Inset>(lhs: BothAxisEdgesAnchor<UndefinedConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Inset>(lhs: BothAxisEdgesAnchor<NoConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Inset>(lhs: BothAxisEdgesAnchor<UndefinedConstant>, rhs: BothAxisEdgesAnchor<Inset>) -> BothAxisEdgesExpression<Inset> {
    BothAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}
