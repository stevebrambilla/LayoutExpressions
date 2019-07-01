//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

#if os(macOS)
import AppKit
#else
import UIKit
#endif

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
		let containerAnchor = AxisAnchor(axis: XAxis(anchor: container.centerXAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: XAxis(anchor: subview.leftAnchor), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .left)
		XCTAssert(constraint.secondAttribute == .centerX)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 0)
		XCTAssert(constraint.multiplier == 1)
	}

	func testXAxisExpressionWithConstant() {
		let containerAnchor = AxisAnchor(axis: XAxis(anchor: container.centerXAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: XAxis(anchor: subview.leftAnchor), constant: UndefinedConstant())

		let expression = (subviewAnchor == containerAnchor + 10)
		let constraint = expression.evaluateDistinct()
		XCTAssert(constraint.firstItem === subview)
		XCTAssert(constraint.secondItem === container)
		XCTAssert(constraint.firstAttribute == .left)
		XCTAssert(constraint.secondAttribute == .centerX)
		XCTAssert(constraint.relation == .equal)
		XCTAssert(constraint.constant == 10)
		XCTAssert(constraint.multiplier == 1)
	}

	func testXAxisRelations() {
		let containerAnchor = AxisAnchor(axis: XAxis(anchor: container.centerXAnchor), constant: UndefinedConstant())
		let subviewAnchor = AxisAnchor(axis: XAxis(anchor: subview.leftAnchor), constant: UndefinedConstant())

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
