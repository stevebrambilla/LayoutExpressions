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
		let constraint = evaluateLayoutExpression(subview.lexTop == container.lexTop <<~ 950)
		XCTAssert(constraint.priority == 950.0)
	}

	func testCustomIntPriority() {
		let constraint = evaluateLayoutExpression(subview.lexTop == container.lexTop <<~ 950)
		XCTAssert(constraint.priority == 950)
	}

	func testSystemPriority() {
		let constraint = evaluateLayoutExpression(subview.lexTop == container.lexTop <<~ .DefaultHigh)
		XCTAssert(constraint.priority == SystemPriority.DefaultHigh.rawValue, "Wrong priority")
	}
}
