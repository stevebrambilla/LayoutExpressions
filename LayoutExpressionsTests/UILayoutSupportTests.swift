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
		let top = evaluateExpression(subview.lex_top() == viewController.lex_topLayoutGuide())
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Bottom, "Not bottom edge")

		let left = evaluateExpression(subview.lex_left() == viewController.lex_leftLayoutGuide())
		XCTAssertTrue(left.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(left.secondAttribute == .Right, "Not right edge")

		let bottom = evaluateExpression(subview.lex_bottom() == viewController.lex_bottomLayoutGuide())
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Top, "Not top edge")

		let right = evaluateExpression(subview.lex_right() == viewController.lex_rightLayoutGuide())
		XCTAssertTrue(right.firstAttribute == .Right, "Not right edge")
		XCTAssertTrue(right.secondAttribute == .Left, "Not left edge")
	}

	func testFunctionLayoutGuides() {
		let top = evaluateExpression(subview.lex_top() == topEdgeOf(viewController.topLayoutGuide))
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Top, "Not top edge")

		let left = evaluateExpression(subview.lex_left() == leftEdgeOf(viewController.leftLayoutGuide))
		XCTAssertTrue(left.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(left.secondAttribute == .Left, "Not left edge")

		let bottom = evaluateExpression(subview.lex_bottom() == bottomEdgeOf(viewController.bottomLayoutGuide))
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Bottom, "Not bottom edge")

		let right = evaluateExpression(subview.lex_right() == rightEdgeOf(viewController.rightLayoutGuide))
		XCTAssertTrue(right.firstAttribute == .Right, "Not right edge")
		XCTAssertTrue(right.secondAttribute == .Right, "Not right edge")

		let leading = evaluateExpression(subview.lex_leading() == leadingEdgeOf(viewController.leftLayoutGuide))
		XCTAssertTrue(leading.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(leading.secondAttribute == .Leading, "Not leading edge")

		let trailing = evaluateExpression(subview.lex_trailing() == trailingEdgeOf(viewController.rightLayoutGuide))
		XCTAssertTrue(trailing.firstAttribute == .Trailing, "Not trailing edge")
		XCTAssertTrue(trailing.secondAttribute == .Trailing, "Not trailing edge")
	}
}