//
//  Constraints.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Layout Anchors

internal func constraintForRelation(relation: Relation, leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
	switch relation {
	case .LessThanOrEqual:
		return lessThanOrEqualConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
	case .Equal:
		return equalConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
	case .GreaterThanOrEqual:
		return greaterThanOrEqualConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
	}
}

private func lessThanOrEqualConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
	return leftAnchor.constraintLessThanOrEqualToAnchor(rightAnchor, constant: constant)
}

private func equalConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
	return leftAnchor.constraintEqualToAnchor(rightAnchor, constant: constant)
}

private func greaterThanOrEqualConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
	return leftAnchor.constraintGreaterThanOrEqualToAnchor(rightAnchor, constant: constant)
}

// ----------------------------------------------------------------------------
// MARK: - Dimension Anchors

internal func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
	switch relation {
	case .LessThanOrEqual:
		return lessThanOrEqualConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
	case .Equal:
		return equalConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
	case .GreaterThanOrEqual:
		return greaterThanOrEqualConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
	}
}

private func lessThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
	return leftDimension.constraintLessThanOrEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
}

private func equalConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
	return leftDimension.constraintEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
}

private func greaterThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
	return leftDimension.constraintGreaterThanOrEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
}

internal func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
	switch relation {
	case .LessThanOrEqual:
		return leftDimension.constraintLessThanOrEqualToConstant(constant)
	case .Equal:
		return leftDimension.constraintEqualToConstant(constant)
	case .GreaterThanOrEqual:
		return leftDimension.constraintGreaterThanOrEqualToConstant(constant)
	}
}