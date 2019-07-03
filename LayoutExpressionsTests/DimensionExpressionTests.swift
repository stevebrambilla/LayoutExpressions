//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class DimensionExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testDimensionExpressionWithoutMultiplierOrConstant() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .height)
		XCTAssert(constraint.secondAttribute == .width)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 0)
		XCTAssert(constraint.multiplier == 1)
	}

	func testDimensionExpressionWithConstant() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor + 10)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .height)
		XCTAssert(constraint.secondAttribute == .width)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 10)
		XCTAssert(constraint.multiplier == 1)
	}

	func testDimensionExpressionWithMultiplier() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor * 2)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .height)
		XCTAssert(constraint.secondAttribute == .width)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 0)
		XCTAssert(constraint.multiplier == 2)
	}

	func testDimensionExpressionWithMultiplierAndConstant() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor * 2 + 10)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .height)
		XCTAssert(constraint.secondAttribute == .width)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 10)
		XCTAssert(constraint.multiplier == 2)
	}

	func testDimensionRelations() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let ltExpression = (subviewAnchor <= containerAnchor * 2 + 10)
		let ltConstraint = ltExpression.evaluateDistinct()
		XCTAssert(ltConstraint.relation == .lessThanOrEqual)

		let eqExpression = (subviewAnchor == containerAnchor * 2 + 10)
		let eqConstraint = eqExpression.evaluateDistinct()
		XCTAssert(eqConstraint.relation == .equal)

		let gtExpression = (subviewAnchor >= containerAnchor * 2 + 10)
		let gtConstraint = gtExpression.evaluateDistinct()
		XCTAssert(gtConstraint.relation == .greaterThanOrEqual)
	}
}
