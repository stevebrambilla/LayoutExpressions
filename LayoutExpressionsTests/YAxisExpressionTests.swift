//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

#if os(macOS)
import AppKit
#else
import UIKit
#endif

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
		let containerAnchor = AxisAnchor(axis: YAxis(anchor: container.centerYAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: YAxis(anchor: subview.topAnchor), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .top)
		XCTAssert(constraint.secondAttribute == .centerY)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 0)
		XCTAssert(constraint.multiplier == 1)
	}

	func testYAxisExpressionWithConstant() {
		let containerAnchor = AxisAnchor(axis: YAxis(anchor: container.centerYAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: YAxis(anchor: subview.topAnchor), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor + 10)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .top)
		XCTAssert(constraint.secondAttribute == .centerY)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 10)
		XCTAssert(constraint.multiplier == 1)
	}

	func testYAxisRelations() {
		let containerAnchor = AxisAnchor(axis: YAxis(anchor: container.centerYAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: YAxis(anchor: subview.topAnchor), constant: UndefinedConstant())

		let ltExpression = (subviewAnchor <= containerAnchor + 10)
		let ltConstraint = ltExpression.evaluateDistinct()
		XCTAssert(ltConstraint.relation == .lessThanOrEqual)

		let eqExpression = (subviewAnchor == containerAnchor + 10)
		let eqConstraint = eqExpression.evaluateDistinct()
		XCTAssert(eqConstraint.relation == .equal)

		let gtExpression = (subviewAnchor >= containerAnchor + 10)
		let gtConstraint = gtExpression.evaluateDistinct()
		XCTAssert(gtConstraint.relation == .greaterThanOrEqual)
	}
}
