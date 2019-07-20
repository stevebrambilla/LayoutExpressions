//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import Foundation
@testable import LayoutExpressions
import XCTest

class SizeExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testSizeToView() {
		let expression = (subview.anchors.size == container.anchors.size)
		let constraints = expression.evaluateAll()
        
        let width = extractSingleConstraint(constraints, withAttributes: .width)
        assertConstraint(width, first: subview, second: container)
        
        let height = extractSingleConstraint(constraints, withAttributes: .height)
        assertConstraint(height, first: subview, second: container)
	}

	func testSizeToViewWithOffset() {
		let expression = (subview.anchors.size == container.anchors.size + Size(width: -20, height: -10))
		let constraints = expression.evaluateAll()
        
        let width = extractSingleConstraint(constraints, withAttributes: .width)
        assertConstraint(width, first: subview, second: container, constant: -20)
        
        let height = extractSingleConstraint(constraints, withAttributes: .height)
        assertConstraint(height, first: subview, second: container, constant: -10)
	}

	func testSizeOperators() {
		let eqConstraints = evaluateLayoutExpression(subview.anchors.size == container.anchors.size)
        assertSizeConstraints(eqConstraints, first: subview, relation: .equal, second: container)

		let ltConstraints = evaluateLayoutExpression(subview.anchors.size <= container.anchors.size)
        assertSizeConstraints(ltConstraints, first: subview, relation: .lessThanOrEqual, second: container)

		let gtConstraints = evaluateLayoutExpression(subview.anchors.size >= container.anchors.size)
        assertSizeConstraints(gtConstraints, first: subview, relation: .greaterThanOrEqual, second: container)
	}

	func testFixedSizeOperators() {
		let fixedSize = Size(width: 320.0, height: 400.0)

		let equalsConstraints = evaluateLayoutExpression(subview.anchors.size == fixedSize)
        assertFixedSizeConstraints(equalsConstraints, item: subview, relation: .equal, width: 320, height: 400)

		let ltConstraints = evaluateLayoutExpression(subview.anchors.size <= fixedSize)
        assertFixedSizeConstraints(ltConstraints, item: subview, relation: .lessThanOrEqual, width: 320, height: 400)

		let gtConstraints = evaluateLayoutExpression(subview.anchors.size >= fixedSize)
        assertFixedSizeConstraints(gtConstraints, item: subview, relation: .greaterThanOrEqual, width: 320, height: 400)
	}
    
    func testFixedCGSizeOperators() {
        let fixedCGSize = CGSize(width: 320.0, height: 400.0)
        
        let equalsConstraints = evaluateLayoutExpression(subview.anchors.size == fixedCGSize)
        assertFixedSizeConstraints(equalsConstraints, item: subview, relation: .equal, width: 320, height: 400)
        
        let ltConstraints = evaluateLayoutExpression(subview.anchors.size <= fixedCGSize)
        assertFixedSizeConstraints(ltConstraints, item: subview, relation: .lessThanOrEqual, width: 320, height: 400)
        
        let gtConstraints = evaluateLayoutExpression(subview.anchors.size >= fixedCGSize)
        assertFixedSizeConstraints(gtConstraints, item: subview, relation: .greaterThanOrEqual, width: 320, height: 400)
    }
}

// MARK: - Size Assertions

fileprivate func assertSizeConstraints(
    _ constraints: [Constraint],
    first firstItem: AnyObject?,
    relation: Constraint.Relation? = nil,
    second secondItem: AnyObject?,
    file: StaticString = #file,
    line: UInt = #line
) {
    let width = extractSingleConstraint(constraints, withAttributes: .width)
    assertConstraint(width, first: firstItem, relation: relation, second: secondItem, file: file, line: line)
    
    let height = extractSingleConstraint(constraints, withAttributes: .height)
    assertConstraint(height, first: firstItem, relation: relation, second: secondItem, file: file, line: line)
}

fileprivate func assertFixedSizeConstraints(
    _ constraints: [Constraint],
    item firstItem: AnyObject?,
    relation: Constraint.Relation? = nil,
    width: CGFloat,
    height: CGFloat,
    file: StaticString = #file,
    line: UInt = #line
) {
    let widthConstraint = extractSingleConstraint(constraints, withFirstAttribute: .width)
    assertConstraint(widthConstraint, first: firstItem, relation: relation, second: nil, .notAnAttribute, constant: width, file: file, line: line)
    
    let heightConstraint = extractSingleConstraint(constraints, withFirstAttribute: .height)
    assertConstraint(heightConstraint, first: firstItem, relation: relation, second: nil, .notAnAttribute, constant: height, file: file, line: line)
}
