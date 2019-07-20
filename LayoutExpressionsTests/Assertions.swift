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
func extractSingleConstraint(
    _ constraints: [Constraint],
    withAttributes attribute: Constraint.Attribute,
    file: StaticString = #file,
    line: UInt = #line
) -> Constraint? {
    let matches = constraints.filter { $0.firstAttribute == attribute && $0.secondAttribute == attribute }
    XCTAssert(matches.count == 1, "Didn't find exactly one \(attribute) constraint.", file: file, line: line)
    return matches.first
}

/// Asserts that `contraints` contains a single constraint with the first item's attributes set to
/// `attribute`, and returns the constraint.
func extractSingleConstraint(
    _ constraints: [Constraint],
    withFirstAttribute firstAttribute: Constraint.Attribute,
    file: StaticString = #file,
    line: UInt = #line
) -> Constraint? {
    let matches = constraints.filter { $0.firstAttribute == firstAttribute }
    XCTAssert(matches.count == 1, "Didn't find exactly one \(firstAttribute) constraint.", file: file, line: line)
    return matches.first
}

/// Asserts that `constraint`'s items are identical to `first` and `second`.
///
/// If `multiplier` and/or `constant` are non-nil, also asserts that `constraint`'s values are
/// equal.
func assertConstraint(
    _ constraint: Constraint?,
    first firstItem: AnyObject?,
    _ firstAttribute: Constraint.Attribute? = nil,
    relation: Constraint.Relation? = nil,
    second secondItem: AnyObject?,
    _ secondAttribute: Constraint.Attribute? = nil,
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
    
    XCTAssert(constraint.firstItem === firstItem, "Unexpected first item: \(String(describing: constraint.firstItem))", file: file, line: line)
    
    if let firstAttribute = firstAttribute {
        XCTAssert(constraint.firstAttribute == firstAttribute, "Unexpected first attribute: \(debugString(attribute: constraint.firstAttribute))", file: file, line: line)
    }
    
    if let relation = relation {
        XCTAssert(constraint.relation == relation, "Unexpected relation: \(debugString(relation: constraint.relation))", file: file, line: line)
    }
    
    XCTAssert(constraint.secondItem === secondItem, "Unexpected second item: \(String(describing: constraint.secondItem))", file: file, line: line)
    
    if let secondAttribute = secondAttribute {
        XCTAssert(constraint.secondAttribute == secondAttribute, "Unexpected second attribute: \(debugString(attribute: constraint.secondAttribute))", file: file, line: line)
    }
    
    if let multiplier = multiplier {
        XCTAssert(constraint.multiplier == multiplier, "Unexpected multiplier: \(constraint.multiplier)", file: file, line: line)
    }
    
    if let constant = constant {
        XCTAssert(constraint.constant == constant, "Unexpected constant: \(constraint.constant)", file: file, line: line)
    }
}

fileprivate func debugString(attribute: Constraint.Attribute?) -> String {
    guard let attribute = attribute else { return "nil" }
    
    switch attribute {
    case .left: return ".left"
    case .right: return ".right"
    case .top: return ".top"
    case .bottom: return ".bottom"
    case .leading: return ".leading"
    case .trailing: return ".trailing"
    case .width: return ".width"
    case .height: return ".height"
    case .centerX: return ".centerX"
    case .centerY: return ".centerY"
    case .lastBaseline: return ".lastBaseline"
    case .firstBaseline: return ".firstBaseline"
    
    #if !(os(macOS) && !targetEnvironment(macCatalyst))
    case .leftMargin: return ".leftMargin"
    case .rightMargin: return ".rightMargin"
    case .topMargin: return ".topMargin"
    case .bottomMargin: return ".bottomMargin"
    case .leadingMargin: return ".leadingMargin"
    case .trailingMargin: return ".trailingMargin"
    case .centerXWithinMargins: return ".centerXWithinMargins"
    case .centerYWithinMargins: return ".centerYWithinMargins"
    #endif
    
    case .notAnAttribute: return ".notAnAttribute"
    @unknown default: return "<new attribute>"
    }
}

fileprivate func debugString(relation: Constraint.Relation) -> String {
    switch relation {
    case .lessThanOrEqual: return ".lessThanOrEqual"
    case .equal: return ".equal"
    case .greaterThanOrEqual: return ".greaterThanOrEqual"
    @unknown default: return "<new relation>"
    }
}
