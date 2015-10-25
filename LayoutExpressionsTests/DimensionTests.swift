//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class DimensionTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testFixedWidth() {
		let width = lexEvaluate(subview.lexWidth == 320.0)
		XCTAssertTrue(width.secondAttribute == .NotAnAttribute, "Wrong attribute")
		XCTAssertTrue(width.multiplier == 1.0, "Wrong multiplier")
		XCTAssertTrue(width.constant == 320.0, "Wrong constant")
	}

	func testFixedHeight() {
		let height = lexEvaluate(subview.lexHeight == 50.0)
		XCTAssertTrue(height.secondAttribute == .NotAnAttribute, "Wrong attribute")
		XCTAssertTrue(height.multiplier == 1.0, "Wrong multiplier")
		XCTAssertTrue(height.constant == 50.0, "Wrong constant")
	}
}
