//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class XAxisExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testXAxisExpressionWithoutConstant() {
		let expression = (subview.anchors.left == container.anchors.centerX)
		let constraint = expression.evaluateDistinct()
        
        assertConstraint(constraint, first: subview, .left, relation: .equal, second: container, .centerX, multiplier: 1, constant: 0)
	}

	func testXAxisExpressionWithConstant() {
		let expression = (subview.anchors.left == container.anchors.centerX + 10)
		let constraint = expression.evaluateDistinct()
  
        assertConstraint(constraint, first: subview, .left, relation: .equal, second: container, .centerX, multiplier: 1, constant: 10)
	}

	func testXAxisRelations() {
		let ltExpression = (subview.anchors.left <= container.anchors.centerX + 10)
		let ltConstraint = ltExpression.evaluateDistinct()
        assertConstraint(ltConstraint, first: subview, .left, relation: .lessThanOrEqual, second: container, .centerX, constant: 10)

		let eqExpression = (subview.anchors.left == container.anchors.centerX + 10)
		let eqConstraint = eqExpression.evaluateDistinct()
		assertConstraint(eqConstraint, first: subview, .left, relation: .equal, second: container, .centerX, constant: 10)

		let gtExpression = (subview.anchors.left >= container.anchors.centerX + 10)
		let gtConstraint = gtExpression.evaluateDistinct()
		assertConstraint(gtConstraint, first: subview, .left, relation: .greaterThanOrEqual, second: container, .centerX, constant: 10)
	}
}
