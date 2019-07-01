//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import XCTest
@testable import LayoutExpressions

#if os(macOS)
import AppKit
#else
import UIKit
#endif

class ConstantDimensionExpressionTests: XCTestCase {

	var subview = View()

	override func setUp() {
		super.setUp()

		subview = View()
	}

	func testConstantDimensionExpression() {
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == 200)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem == nil)
		XCTAssert(constraint.firstAttribute == .height)
		XCTAssert(constraint.secondAttribute == .notAnAttribute)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 200)
		XCTAssert(constraint.multiplier == 1)
	}

	func testConstantDimensionRelations() {
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let ltExpression = (subviewAnchor <= 200)
		let ltConstraint = ltExpression.evaluateDistinct()
		XCTAssert(ltConstraint.relation == .lessThanOrEqual)

		let eqExpression = (subviewAnchor == 200)
		let eqConstraint = eqExpression.evaluateDistinct()
		XCTAssert(eqConstraint.relation == .equal)

		let gtExpression = (subviewAnchor >= 200)
		let gtConstraint = gtExpression.evaluateDistinct()
		XCTAssert(gtConstraint.relation == .greaterThanOrEqual)
	}
}
