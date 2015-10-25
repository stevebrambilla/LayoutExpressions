//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public struct Expression<Left: LeftArgument, Right: RightArgument>: ExpressionType {
	private let lhs: Left
	private let relation: NSLayoutRelation
	private let rhs: Right
	private let priority: Priority?

	internal init(lhs: Left, relation: NSLayoutRelation, rhs: Right, priority: Priority? = nil) {
		self.lhs = lhs
		self.relation = relation
		self.rhs = rhs
		self.priority = priority
	}

	internal func updatePriority(priority: Priority) -> Expression {
		return Expression(lhs: lhs, relation: relation, rhs: rhs, priority: priority)
	}

	internal func evaluate() -> [NSLayoutConstraint] {
		var constraints = [NSLayoutConstraint]()

		for leftAttribute in lhs.leftAttributes {
			let params = rhs.rightParametersForAttribute(leftAttribute)

			let constraint = NSLayoutConstraint(
				item: lhs.leftItem,
				attribute: leftAttribute,
				relatedBy: relation,
				toItem: params.item,
				attribute: params.attribute,
				multiplier: params.multiplier ?? 1.0,
				constant: params.constant ?? 0.0
			)

			constraints.append(constraint)
		}

		if let priority = priority {
			constraints.forEach { $0.priority = priority }
		}

		return constraints
	}
}

protocol ExpressionType {
	func evaluate() -> [NSLayoutConstraint]
}

extension Expression where Left: DistinctLeftArgument, Right: DistinctRightArgument {
	internal func evaluateDistinct() -> NSLayoutConstraint {
		let params = rhs.distinctRightParameters

		let constraint = NSLayoutConstraint(
			item: lhs.leftItem,
			attribute: lhs.distinctLeftAttribute,
			relatedBy: relation,
			toItem: params.item,
			attribute: params.attribute,
			multiplier: params.multiplier ?? 1.0,
			constant: params.constant ?? 0.0
		)

		if let priority = priority {
			constraint.priority = priority
		}

		return constraint
	}
}

extension SequenceType where Generator.Element: ExpressionType {
	internal func evaluate() -> [NSLayoutConstraint] {
		return reduce([], combine: { constraints, expression in
			return constraints + expression.evaluate()
		})
	}
}
