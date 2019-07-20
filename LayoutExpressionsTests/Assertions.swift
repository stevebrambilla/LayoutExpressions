//
//  Assertions.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2019-07-20.
//  Copyright © 2019 Steve Brambilla. All rights reserved.
//

@testable import LayoutExpressions
import XCTest

/// Asserts that `contraints` contains a single constraint with both attributes set to `attribute`,
/// and returns the constraint.
func unwrapSingleConstraint(
    _ constraints: [Constraint],
    withAttribute attribute: Constraint.Attribute,
    file: StaticString = #file,
    line: UInt = #line
) -> Constraint? {
    let matches = constraints.filter { $0.firstAttribute == attribute && $0.secondAttribute == attribute }
    XCTAssert(matches.count == 1, "Didn't find exactly one \(attribute) constraint.", file: file, line: line)
    return matches.first
}

/// Asserts that `constraint`'s items are identical to `first` and `second`.
///
/// If `multiplier` and/or `constant` are non-nil, also asserts that `constraint`'s values are
/// equal.
func assertConstraint(
    _ constraint: Constraint?,
    first: AnyObject?,
    second: AnyObject?,
    multiplier: CGFloat? = nil,
    constant: CGFloat? = nil,
    file: StaticString = #file,
    line: UInt = #line
) {
    // Accept nil for `constraint` for convenience, but always fail if nil.
    guard let constraint = constraint else {
        XCTFail("The given constraint is nil.", file: file, line: line)
        return
    }
    
    XCTAssert(constraint.firstItem === first, file: file, line: line)
    XCTAssert(constraint.secondItem === second, file: file, line: line)
    
    if let multiplier = multiplier {
        XCTAssert(constraint.multiplier == multiplier, file: file, line: line)
    }
    
    if let constant = constant {
        XCTAssert(constraint.constant == constant, file: file, line: line)
    }
}
