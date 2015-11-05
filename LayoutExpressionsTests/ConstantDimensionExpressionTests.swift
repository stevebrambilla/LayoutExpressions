//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import XCTest

import UIKit
@testable import LayoutExpressions

class ConstantDimensionExpressionTests: XCTestCase {

	var subview = UIView()

	override func setUp() {
		super.setUp()

		subview = UIView()
	}

	func testConstantDimensionExpression() {
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == 200)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem == nil)
		XCTAssert(constraint.firstAttribute == .Height)
		XCTAssert(constraint.secondAttribute == .NotAnAttribute)
		XCTAssert(constraint.relation == .Equal)
		XCTAssert(constraint.constant == 200)
		XCTAssert(constraint.multiplier == 1)
	}

	func testConstantDimensionRelations() {
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let ltExpression = (subviewAnchor <= 200)
		let ltConstraint = ltExpression.evaluateDistinct()
		XCTAssert(ltConstraint.relation == .LessThanOrEqual)

		let eqExpression = (subviewAnchor == 200)
		let eqConstraint = eqExpression.evaluateDistinct()
		XCTAssert(eqConstraint.relation == .Equal)

		let gtExpression = (subviewAnchor >= 200)
		let gtConstraint = gtExpression.evaluateDistinct()
		XCTAssert(gtConstraint.relation == .GreaterThanOrEqual)
	}
}
