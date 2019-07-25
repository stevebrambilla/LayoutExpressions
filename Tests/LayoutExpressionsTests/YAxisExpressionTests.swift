//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class YAxisExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testYAxisExpressionWithoutConstant() {
		let expression = (subview.anchors.top == container.anchors.centerY)
		let constraint = expression.evaluateDistinct()
  
        assertConstraint(constraint, first: subview, .top, relation: .equal, second: container, .centerY, multiplier: 1, constant: 0)
	}

	func testYAxisExpressionWithConstant() {
		let expression = (subview.anchors.top == container.anchors.centerY + 10)
		let constraint = expression.evaluateDistinct()
  
        assertConstraint(constraint, first: subview, .top, relation: .equal, second: container, .centerY, multiplier: 1, constant: 10)
	}

	func testYAxisRelations() {
		let ltExpression = (subview.anchors.top <= container.anchors.centerY + 10)
		let ltConstraint = ltExpression.evaluateDistinct()
        assertConstraint(ltConstraint, first: subview, .top, relation: .lessThanOrEqual, second: container, .centerY, constant: 10)

		let eqExpression = (subview.anchors.top == container.anchors.centerY + 10)
		let eqConstraint = eqExpression.evaluateDistinct()
        assertConstraint(eqConstraint, first: subview, .top, relation: .equal, second: container, .centerY, constant: 10)

		let gtExpression = (subview.anchors.top >= container.anchors.centerY + 10)
		let gtConstraint = gtExpression.evaluateDistinct()
        assertConstraint(gtConstraint, first: subview, .top, relation: .greaterThanOrEqual, second: container, .centerY, constant: 10)
	}
}
