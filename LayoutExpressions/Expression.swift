//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ------------------------------------------------------------------------------------------------
// MARK: - Expression

public class Expression <Left: LeftHandSideArgument, Right: RightHandSideArgument> {
	private let lhs: Left
	private let relation: NSLayoutRelation
	private let rhs: Right
	private let priority: Priority?

	init(lhs: Left, relation: NSLayoutRelation, rhs: Right, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	private func updatePriority(priority: Priority) -> Expression {
		return Expression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	private func evaluate() -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()

		// Create the NSLayoutConstraints.
		for leftAttribute in lhs.leftHandSideAttributes {
			let values = rhs.rightHandSideValues(leftAttribute)
			let c = NSLayoutConstraint(item: lhs.leftHandSideItem,
			                      attribute: leftAttribute,
			                      relatedBy: relation,
			                         toItem: values.item,
			                      attribute: values.attribute,
			                     multiplier: values.multiplier ?? 1.0,
			                       constant: values.constant ?? 0.0)
			constraints.append(c)
		}

		// Apply the priority to them.
		if let priority = priority {
			for constraint in constraints {
				constraint.priority = priority
			}
		}
		return constraints
	}
}

// ------------------------------------------------------------------------------------------------
// MARK: - Argument Protocols

public protocol LeftHandSideArgument {
	var leftHandSideItem: AnyObject { get }
	var leftHandSideAttributes: [NSLayoutAttribute] { get }
}

public protocol RightHandSideArgument {
	func rightHandSideValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?)
}

public protocol DistinctLeftHandSideArgument: LeftHandSideArgument {
	var distinctLeftHandSideAttribute: NSLayoutAttribute { get }
}

public protocol DistinctRightHandSideArgument: RightHandSideArgument {
	var distinctRightHandSideValue: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) { get }
}

// ------------------------------------------------------------------------------------------------
// MARK: - Priority

public typealias Priority = Float

public enum SystemPriority: Priority {
	case Required = 1000
	case DefaultHigh = 750
	case DefaultLow = 250
	case FittingSizeLevel = 50
}

infix operator  <~ {
	associativity left
	precedence 125 // Less than the Comparative operators (130)
}

public func <~ <Left: LeftHandSideArgument, Right: RightHandSideArgument>(expression: Expression<Left, Right>, priority: SystemPriority) -> Expression<Left, Right> {
	return expression.updatePriority(priority.rawValue)
}

public func <~ <Left: LeftHandSideArgument, Right: RightHandSideArgument>(expression: Expression<Left, Right>, priority: Priority) -> Expression<Left, Right> {
	return expression.updatePriority(priority)
}

// ------------------------------------------------------------------------------------------------
// MARK: - Evaluation Functions

/// Evaluates a distinct layout expression into a single constraint.
///
/// Returns an evaluated NSLayoutConstraint
public func evaluateExpression<Left: DistinctLeftHandSideArgument, Right: DistinctRightHandSideArgument>(expression: Expression<Left, Right>) -> NSLayoutConstraint {
	let constraints = expression.evaluate()
	assert(constraints.count == 1, "A distinct expression should never evaluate to more than 1 layout constraint.")
	return constraints[0]
}

/// Evaluates a layout expression into constraints.
///
/// Returns an array of layout constraints.
public func evaluateExpression<Left: LeftHandSideArgument, Right: RightHandSideArgument>(expression: Expression<Left, Right>) -> [NSLayoutConstraint] {
	return evaluateExpressions([ expression ])
}

/// Evaluates multiple layout expressions into constraints.
///
/// Returns an array of layout constraints.
public func evaluateExpressions<Left: LeftHandSideArgument, Right: RightHandSideArgument>(expressions: [Expression<Left, Right>]) -> [NSLayoutConstraint] {
	var constraints = [NSLayoutConstraint]()
	for expr in expressions {
		constraints += expr.evaluate()
	}
	return constraints
}
