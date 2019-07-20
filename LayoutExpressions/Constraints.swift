//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if os(macOS)
import AppKit
#else
import UIKit
#endif

// MARK: - Layout Anchors

internal struct AnchorConstraints {
	internal static func constraintForRelation<AnchorType>(relation: Relation, lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		case .equal:
			return equalConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		lhsAnchor.constraint(lessThanOrEqualTo: rhsAnchor, constant: constant)
	}

	fileprivate static func equalConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		lhsAnchor.constraint(equalTo: rhsAnchor, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> NSLayoutConstraint {
		lhsAnchor.constraint(greaterThanOrEqualTo: rhsAnchor, constant: constant)
	}
}

// MARK: - Dimension Anchors

internal struct DimensionConstraints {
	internal static func constraintForRelation(relation: Relation, lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		case .equal:
			return equalConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		lhsDimension.constraint(lessThanOrEqualTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func equalConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		lhsDimension.constraint(equalTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
		lhsDimension.constraint(greaterThanOrEqualTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	internal static func constraintForRelation(relation: Relation, lhsDimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
		switch relation {
		case .lessThanOrEqual:
			return lhsDimension.constraint(lessThanOrEqualToConstant: constant)
		case .equal:
			return lhsDimension.constraint(equalToConstant: constant)
		case .greaterThanOrEqual:
			return lhsDimension.constraint(greaterThanOrEqualToConstant: constant)
		}
	}
}
