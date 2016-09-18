//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - Layout Anchors

internal struct AnchorConstraints {
	internal static func constraintForRelation<AnchorType: AnyObject>(relation: Relation, leftAnchor: NSLayoutAnchor<AnchorType>, rightAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraintForLeftAnchor(leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)
		case .equal:
			return equalConstraintForLeftAnchor(leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraintForLeftAnchor(leftAnchor: leftAnchor, rightAnchor: rightAnchor, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraintForLeftAnchor<AnchorType: AnyObject>(leftAnchor: NSLayoutAnchor<AnchorType>, rightAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: constant)
	}

	fileprivate static func equalConstraintForLeftAnchor<AnchorType: AnyObject>(leftAnchor: NSLayoutAnchor<AnchorType>, rightAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraint(equalTo: rightAnchor, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraintForLeftAnchor<AnchorType: AnyObject>(leftAnchor: NSLayoutAnchor<AnchorType>, rightAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		return leftAnchor.constraint(greaterThanOrEqualTo: rightAnchor, constant: constant)
	}
}

// ----------------------------------------------------------------------------
// MARK: - Dimension Anchors

internal struct DimensionConstraints {
	internal static func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraintForLeftDimension(leftDimension: leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		case .equal:
			return equalConstraintForLeftDimension(leftDimension: leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraintForLeftDimension(leftDimension: leftDimension, rightDimension: rightDimension, multiplier: multiplier, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraint(lessThanOrEqualTo: rightDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func equalConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraint(equalTo: rightDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraintForLeftDimension(leftDimension: NSLayoutDimension, rightDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		return leftDimension.constraint(greaterThanOrEqualTo: rightDimension, multiplier: multiplier, constant: constant)
	}

	internal static func constraintForRelation(relation: Relation, leftDimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return leftDimension.constraint(lessThanOrEqualToConstant: constant)
		case .equal:
			return leftDimension.constraint(equalToConstant: constant)
		case .greaterThanOrEqual:
			return leftDimension.constraint(greaterThanOrEqualToConstant: constant)
		}
	}
}
