//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

class Expression <L: LeftHandSideArgument, R: RightHandSideArgument> {
	let _lhs: L
	let _relation: NSLayoutRelation
	let _rhs: R
	let _priority: Priority?

	init(lhs: L, relation: NSLayoutRelation, rhs: R, priority: Priority? = nil) {
		_lhs = lhs
		_relation = relation
		_rhs = rhs
		_priority = priority
	}

	func updatePriority(priority: Priority) -> Expression {
		return Expression(lhs: _lhs, relation: _relation, rhs: _rhs, priority: priority)
	}

	func evaluate() -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()

		// Create the NSLayoutConstraints.
		for leftAttribute in _lhs.attributes {
			let values = _rhs.attributeValues(leftAttribute)
			constraints += NSLayoutConstraint(item: _lhs.item,
			                             attribute: leftAttribute,
			                             relatedBy: _relation,
			                                toItem: values.item,
			                             attribute: values.attribute,
			                            multiplier: values.multiplier ? values.multiplier! : 1.0,
			                              constant: values.constant ? values.constant! : 0.0)
		}

		// Apply the priority to them.
		if let priority = _priority {
			for constraint in constraints {
				constraint.priority = priority
			}
		}
		return constraints
	}
}

protocol LeftHandSideArgument {
	var item: AnyObject { get }
	var attributes: [NSLayoutAttribute] { get }
}

protocol RightHandSideArgument {
	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?)
}

protocol DistinctLeftHandSideArgument: LeftHandSideArgument {
	var attribute: NSLayoutAttribute { get }
}

protocol DistinctRightHandSideArgument: RightHandSideArgument {
	var attributeValues: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) { get }
}

// MARK: Evaluation Functions

/// Evaluates a distinct layout expression into a single constraint.
///
/// Returns an evaluated NSLayoutConstraint
func evaluateExpression<L: DistinctLeftHandSideArgument, R: DistinctRightHandSideArgument>(expression: Expression<L, R>) -> NSLayoutConstraint {
	let constraints = expression.evaluate()
	assert(constraints.count == 1, "A distinct expression should never evaluate to more than 1 layout constraint.")
	return constraints[0]
}

/// Evaluates a layout expression into constraints.
///
/// Returns an array of layout constraints.
func evaluateExpression<L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>) -> [NSLayoutConstraint] {
	return evaluateExpressions([ expression ])
}

/// Evaluates multiple layout expressions into constraints.
///
/// Returns an array of layout constraints.
func evaluateExpressions<L: LeftHandSideArgument, R: RightHandSideArgument>(expressions: [Expression<L, R>]) -> [NSLayoutConstraint] {
	var constraints = [NSLayoutConstraint]()
	for expr in expressions {
		constraints += expr.evaluate()
	}
	return constraints
}
