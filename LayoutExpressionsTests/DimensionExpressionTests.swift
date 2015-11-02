//
//  DimensionExpressionTests.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import XCTest

import UIKit
@testable import LayoutExpressions

class DimensionExpressionTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testDimensionExpressionWithoutMultiplierOrConstant() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .Height)
		XCTAssert(constraint.secondAttribute == .Width)
		XCTAssert(constraint.relation == .Equal)
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
		XCTAssert(constraint.firstAttribute == .Height)
		XCTAssert(constraint.secondAttribute == .Width)
		XCTAssert(constraint.relation == .Equal)
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
		XCTAssert(constraint.firstAttribute == .Height)
		XCTAssert(constraint.secondAttribute == .Width)
		XCTAssert(constraint.relation == .Equal)
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
		XCTAssert(constraint.firstAttribute == .Height)
		XCTAssert(constraint.secondAttribute == .Width)
		XCTAssert(constraint.relation == .Equal)
		XCTAssert(constraint.constant == 10)
		XCTAssert(constraint.multiplier == 2)
	}

	func testDimensionRelations() {
		let containerAnchor = DimensionAnchor(dimension: container.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
		let subviewAnchor = DimensionAnchor(dimension: subview.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())

		let ltExpression = (subviewAnchor <= containerAnchor * 2 + 10)
		let ltConstraint = ltExpression.evaluateDistinct()
		XCTAssert(ltConstraint.relation == .LessThanOrEqual)

		let eqExpression = (subviewAnchor == containerAnchor * 2 + 10)
		let eqConstraint = eqExpression.evaluateDistinct()
		XCTAssert(eqConstraint.relation == .Equal)

		let gtExpression = (subviewAnchor >= containerAnchor * 2 + 10)
		let gtConstraint = gtExpression.evaluateDistinct()
		XCTAssert(gtConstraint.relation == .GreaterThanOrEqual)
	}
}
