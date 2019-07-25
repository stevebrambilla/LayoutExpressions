//  Copyright (c) 2019 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

// Supports pinning edges in a single dimension:
//      subview.anchors.verticalEdges == container.anchors.verticalEdges
//
// Supports insets using the '-' operator:
//      subview.anchors.verticalEdges == container.anchors.verticalEdges - 10
//
// The '+' operator defines outsets:
//      subview.anchors.verticalEdges == container.anchors.verticalEdges + 10

// MARK: - Axis Edge

public protocol AxisEdgesProtocol {
    associatedtype AnchorType: AnyObject
    var firstAnchor: NSLayoutAnchor<AnchorType> { get }
    var secondAnchor: NSLayoutAnchor<AnchorType> { get }
}

public struct XAxisEdges: AxisEdgesProtocol {
    public let firstAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
    public let secondAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
    internal init(leading: NSLayoutAnchor<NSLayoutXAxisAnchor>, trailing: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
        self.firstAnchor = leading
        self.secondAnchor = trailing
    }
}

public struct YAxisEdges: AxisEdgesProtocol {
    public let firstAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
    public let secondAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>
    internal init(top: NSLayoutAnchor<NSLayoutYAxisAnchor>, bottom: NSLayoutAnchor<NSLayoutYAxisAnchor>) {
        self.firstAnchor = top
        self.secondAnchor = bottom
    }
}

// MARK: - Single Axis Edges Expression

public struct SingleAxisEdgesExpression<Axis: AxisEdgesProtocol, Inset: ConstantProtocol>: ExpressionProtocol {
    fileprivate let lhs: SingleAxisEdgesAnchor<Axis, NoConstant>
    fileprivate let relation: Relation
    fileprivate let rhs: SingleAxisEdgesAnchor<Axis, Inset>
    fileprivate let priority: Priority?

    fileprivate init(lhs: SingleAxisEdgesAnchor<Axis, NoConstant>, relation: Relation, rhs: SingleAxisEdgesAnchor<Axis, Inset>, priority: Priority? = nil) {
        self.lhs = lhs
        self.relation = relation
        self.rhs = rhs
        self.priority = priority
    }

    public func update(priority: Priority) -> SingleAxisEdgesExpression {
        assert(priority.isValid)
        return SingleAxisEdgesExpression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
    }

    public func evaluateAll() -> [Constraint] {
        let inset = rhs.inset.value ?? 0

        // top, leading
        let firstConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.firstAnchor, rhsAnchor: rhs.firstAnchor, constant: -inset)

        // bottom, trailing
        let secondConstraint = AnchorConstraints.constraintForRelation(relation: relation, lhsAnchor: lhs.secondAnchor, rhsAnchor: rhs.secondAnchor, constant: inset)

        if let priority = priority {
            firstConstraint.priority = priority.layoutPriority
            secondConstraint.priority = priority.layoutPriority
        }

        return [firstConstraint, secondConstraint]
    }
}

// MARK: - Single Axis Edges Anchor

public struct SingleAxisEdgesAnchor<Axis: AxisEdgesProtocol, Inset: ConstantProtocol> {
    fileprivate let axis: Axis
    public let inset: Inset

    internal init(axis: Axis, inset: Inset) {
        self.axis = axis
        self.inset = inset
    }

    fileprivate var firstAnchor: NSLayoutAnchor<Axis.AnchorType> {
        axis.firstAnchor
    }

    fileprivate var secondAnchor: NSLayoutAnchor<Axis.AnchorType> {
        axis.secondAnchor
    }

    fileprivate func update<NextInset>(inset: NextInset) -> SingleAxisEdgesAnchor<Axis, NextInset> {
        SingleAxisEdgesAnchor<Axis, NextInset>(axis: axis, inset: inset)
    }

    fileprivate var withoutModifiers: SingleAxisEdgesAnchor<Axis, NoConstant> {
        SingleAxisEdgesAnchor<Axis, NoConstant>(axis: axis, inset: NoConstant())
    }
}

// MARK: - Arithmetic Operators

// CGFloat Insets / Outsets

public func - <Axis>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, inset: CGFloat) -> SingleAxisEdgesAnchor<Axis, ValueConstant> {
    return lhs.update(inset: ValueConstant(value: -inset))
}

public func + <Axis>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, outset: CGFloat) -> SingleAxisEdgesAnchor<Axis, ValueConstant> {
    return lhs.update(inset: ValueConstant(value: outset))
}

// Int Insets / Outsets

public func - <Axis>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, inset: Int) -> SingleAxisEdgesAnchor<Axis, ValueConstant> {
    lhs - CGFloat(inset)
}

public func + <Axis>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, outset: Int) -> SingleAxisEdgesAnchor<Axis, ValueConstant> {
    lhs + CGFloat(outset)
}

// MARK: - Comparison Operators

public func == <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, NoConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs, relation: .equal, rhs: rhs)
}

public func == <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .equal, rhs: rhs)
}

public func <= <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, NoConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs, relation: .lessThanOrEqual, rhs: rhs)
}

public func <= <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .lessThanOrEqual, rhs: rhs)
}

public func >= <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, NoConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs, relation: .greaterThanOrEqual, rhs: rhs)
}

public func >= <Axis, Inset>(lhs: SingleAxisEdgesAnchor<Axis, UndefinedConstant>, rhs: SingleAxisEdgesAnchor<Axis, Inset>) -> SingleAxisEdgesExpression<Axis, Inset> {
    SingleAxisEdgesExpression(lhs: lhs.withoutModifiers, relation: .greaterThanOrEqual, rhs: rhs)
}
