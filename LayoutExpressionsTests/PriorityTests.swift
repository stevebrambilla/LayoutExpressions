//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

@testable import LayoutExpressions

class PriorityTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testCustomFloatPriority() {
		let constraint = evaluateLayoutExpression(subview.anchors.top == container.anchors.top <<~ 950)
		XCTAssert(constraint.priority.rawValue == 950.0)
	}

	func testCustomIntPriority() {
		let constraint = evaluateLayoutExpression(subview.anchors.top == container.anchors.top <<~ 950)
		XCTAssert(constraint.priority.rawValue == 950)
	}

	func testSystemPriority() {
		let constraint = evaluateLayoutExpression(subview.anchors.top == container.anchors.top <<~ .defaultHigh)
		XCTAssert(constraint.priority.rawValue == SystemPriority.defaultHigh.rawValue, "Wrong priority")
	}
}
