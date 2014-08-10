//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class LayoutSupportTests: XCTestCase {

	var viewController = UIViewController()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		viewController = UIViewController()
		subview = UIView()

		viewController.view.addSubview(subview)
	}

	func testExtensionLayoutGuides() {
		let top = evaluateExpression(subview.lex_top == viewController.lex_topLayoutGuide)
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Bottom, "Not bottom edge")

		let bottom = evaluateExpression(subview.lex_bottom == viewController.lex_bottomLayoutGuide)
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Top, "Not top edge")
	}

	func testFunctionLayoutGuides() {
		let top = evaluateExpression(subview.lex_top == topEdgeOf(viewController.topLayoutGuide))
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Top, "Not top edge")

		let bottom = evaluateExpression(subview.lex_bottom == bottomEdgeOf(viewController.bottomLayoutGuide))
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Bottom, "Not bottom edge")
	}
}