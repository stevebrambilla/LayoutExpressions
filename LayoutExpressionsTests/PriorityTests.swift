//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class PriorityTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testCustomPriority() {
		let constraint = evaluateExpression(subview.lex_top() == container.lex_top() <~ 950)
		XCTAssertTrue(constraint.priority == 950, "Wrong priority")
	}

	func testSystemPriority() {
		let constraint = evaluateExpression(subview.lex_top() == container.lex_top() <~ .DefaultHigh)
		XCTAssertTrue(constraint.priority == SystemPriority.DefaultHigh.toRaw(), "Wrong priority")
	}
}
