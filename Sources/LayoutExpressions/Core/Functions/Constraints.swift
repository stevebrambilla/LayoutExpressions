//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

// MARK: - Layout Anchors

internal struct AnchorConstraints {
	internal static func constraintForRelation<AnchorType>(relation: Relation, lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> Constraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		case .equal:
			return equalConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraint(lhsAnchor: lhsAnchor, rhsAnchor: rhsAnchor, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> Constraint {
		lhsAnchor.constraint(lessThanOrEqualTo: rhsAnchor, constant: constant)
	}

	fileprivate static func equalConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> Constraint {
		lhsAnchor.constraint(equalTo: rhsAnchor, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraint<AnchorType>(lhsAnchor: NSLayoutAnchor<AnchorType>, rhsAnchor: NSLayoutAnchor<AnchorType>, constant: CGFloat) -> Constraint {
		lhsAnchor.constraint(greaterThanOrEqualTo: rhsAnchor, constant: constant)
	}
}

// MARK: - Dimension Anchors

internal struct DimensionConstraints {
	internal static func constraintForRelation(relation: Relation, lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> Constraint {
		switch relation {
		case .lessThanOrEqual:
			return lessThanOrEqualConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		case .equal:
			return equalConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		case .greaterThanOrEqual:
			return greaterThanOrEqualConstraint(lhsDimension: lhsDimension, rhsDimension: rhsDimension, multiplier: multiplier, constant: constant)
		}
	}

	fileprivate static func lessThanOrEqualConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> Constraint {
		lhsDimension.constraint(lessThanOrEqualTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func equalConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> Constraint {
		lhsDimension.constraint(equalTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	fileprivate static func greaterThanOrEqualConstraint(lhsDimension: NSLayoutDimension, rhsDimension: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> Constraint {
		lhsDimension.constraint(greaterThanOrEqualTo: rhsDimension, multiplier: multiplier, constant: constant)
	}

	internal static func constraintForRelation(relation: Relation, lhsDimension: NSLayoutDimension, constant: CGFloat) -> Constraint {
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
