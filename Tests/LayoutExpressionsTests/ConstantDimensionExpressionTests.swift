//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class ConstantDimensionExpressionTests: XCTestCase {

	var subview = View()

	override func setUp() {
		super.setUp()

		subview = View()
	}

	func testConstantDimensionExpression() {
		let expression = (subview.anchors.height == 200)
		let constraint = expression.evaluateDistinct()
        
        assertConstraint(constraint, first: subview, .height, relation: .equal, second: nil, .notAnAttribute, multiplier: 1, constant: 200)
	}

	func testConstantDimensionRelations() {
		let ltExpression = (subview.anchors.height <= 200)
		let ltConstraint = ltExpression.evaluateDistinct()
        assertConstraint(ltConstraint, first: subview, .height, relation: .lessThanOrEqual, second: nil, constant: 200)

		let eqExpression = (subview.anchors.height == 200)
		let eqConstraint = eqExpression.evaluateDistinct()
        assertConstraint(eqConstraint, first: subview, .height, relation: .equal, second: nil, constant: 200)

		let gtExpression = (subview.anchors.height >= 200)
		let gtConstraint = gtExpression.evaluateDistinct()
        assertConstraint(gtConstraint, first: subview, .height, relation: .greaterThanOrEqual, second: nil, constant: 200)
	}
}
