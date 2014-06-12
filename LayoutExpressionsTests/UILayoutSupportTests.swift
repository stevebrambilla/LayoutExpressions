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

	func testImplicitLayoutGuides() {
		let topArray = evaluateExpression(subview.lex_top() == viewController.topLayoutGuide)
		let top = topArray[0]
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Top, "Not top edge")

		let leftArray = evaluateExpression(subview.lex_left() == viewController.leftLayoutGuide)
		let left = leftArray[0]
		XCTAssertTrue(left.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(left.secondAttribute == .Left, "Not left edge")

		let bottomArray = evaluateExpression(subview.lex_bottom() == viewController.bottomLayoutGuide)
		let bottom = bottomArray[0]
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Bottom, "Not bottom edge")

		let rightArray = evaluateExpression(subview.lex_right() == viewController.rightLayoutGuide)
		let right = rightArray[0]
		XCTAssertTrue(right.firstAttribute == .Right, "Not right edge")
		XCTAssertTrue(right.secondAttribute == .Right, "Not right edge")

		let leadingArray = evaluateExpression(subview.lex_leading() == viewController.leftLayoutGuide)
		let leading = leadingArray[0]
		XCTAssertTrue(leading.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(leading.secondAttribute == .Leading, "Not leading edge")

		let trailingArray = evaluateExpression(subview.lex_trailing() == viewController.rightLayoutGuide)
		let trailing = trailingArray[0]
		XCTAssertTrue(trailing.firstAttribute == .Trailing, "Not trailing edge")
		XCTAssertTrue(trailing.secondAttribute == .Trailing, "Not trailing edge")
	}

	func testExplicitLayoutGuides() {
		let topArray = evaluateExpression(subview.lex_top() == topEdgeOf(viewController.topLayoutGuide))
		let top = topArray[0]
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Top, "Not top edge")

		let leftArray = evaluateExpression(subview.lex_left() == leftEdgeOf(viewController.leftLayoutGuide))
		let left = leftArray[0]
		XCTAssertTrue(left.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(left.secondAttribute == .Left, "Not left edge")

		let bottomArray = evaluateExpression(subview.lex_bottom() == bottomEdgeOf(viewController.bottomLayoutGuide))
		let bottom = bottomArray[0]
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Bottom, "Not bottom edge")

		let rightArray = evaluateExpression(subview.lex_right() == rightEdgeOf(viewController.rightLayoutGuide))
		let right = rightArray[0]
		XCTAssertTrue(right.firstAttribute == .Right, "Not right edge")
		XCTAssertTrue(right.secondAttribute == .Right, "Not right edge")

		let leadingArray = evaluateExpression(subview.lex_leading() == leadingEdgeOf(viewController.leftLayoutGuide))
		let leading = leadingArray[0]
		XCTAssertTrue(leading.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(leading.secondAttribute == .Leading, "Not leading edge")

		let trailingArray = evaluateExpression(subview.lex_trailing() == trailingEdgeOf(viewController.rightLayoutGuide))
		let trailing = trailingArray[0]
		XCTAssertTrue(trailing.firstAttribute == .Trailing, "Not trailing edge")
		XCTAssertTrue(trailing.secondAttribute == .Trailing, "Not trailing edge")
	}

	func testExplicitLayoutGuideWithMultiplier() {
		let constraintArray = evaluateExpression(subview.lex_leading() == leftEdgeOf(viewController.leftLayoutGuide) * 2)
		let constraint = constraintArray[0]
		XCTAssertTrue(constraint.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(constraint.secondAttribute == .Left, "Not left edge")
		XCTAssertTrue(constraint.multiplier == 2.0, "Wrong multiplier")
	}

	func testExplicitLayoutGuideWithConstant() {
		let constraintArray = evaluateExpression(subview.lex_leading() == leftEdgeOf(viewController.leftLayoutGuide) + 20)
		let constraint = constraintArray[0]
		XCTAssertTrue(constraint.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(constraint.secondAttribute == .Left, "Not left edge")
		XCTAssertTrue(constraint.constant == 20, "Wrong constant")
	}
}