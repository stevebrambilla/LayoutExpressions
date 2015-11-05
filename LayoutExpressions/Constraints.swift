//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Layout Anchors

internal struct AnchorConstraints {
	internal static func constraintForRelation(relation: Relation, leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .LessThanOrEqual:
			return lessThanOrEqualConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
		case .Equal:
			return equalConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
		case .GreaterThanOrEqual:
			return greaterThanOrEqualConstraintForLeftAnchor(leftAnchor, rightAnchor: rightAnchor, constant: constant)
		}
	}

	private static func lessThanOrEqualConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraintLessThanOrEqualToAnchor(rightAnchor, constant: constant)
	}

	private static func equalConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraintEqualToAnchor(rightAnchor, constant: constant)
	}

	private static func greaterThanOrEqualConstraintForLeftAnchor(leftAnchor: NSLayoutAnchor, rightAnchor: NSLayoutAnchor, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraintGreaterThanOrEqualToAnchor(rightAnchor, constant: constant)
	}
}

// ----------------------------------------------------------------------------
// MARK: - Dimension Anchors

internal struct DimensionConstraints {
	internal static func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .LessThanOrEqual:
			return lessThanOrEqualConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		case .Equal:
			return equalConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		case .GreaterThanOrEqual:
			return greaterThanOrEqualConstraintForLeftDimension(leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		}
	}

	private static func lessThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraintLessThanOrEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
	}

	private static func equalConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraintEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
	}

	private static func greaterThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraintGreaterThanOrEqualToAnchor(rightDimension, multiplier: multiplier, constant: constant)
	}

	internal static func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .LessThanOrEqual:
			return leftDimension.constraintLessThanOrEqualToConstant(constant)
		case .Equal:
			return leftDimension.constraintEqualToConstant(constant)
		case .GreaterThanOrEqual:
			return leftDimension.constraintGreaterThanOrEqualToConstant(constant)
		}
	}
}
