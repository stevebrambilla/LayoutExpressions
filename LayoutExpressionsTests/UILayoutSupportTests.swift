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

	func testViewControllerExtensionLayoutGuides() {
		let top = evaluateExpression(subview.lexTop == viewController.lexTopLayoutGuide)
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Bottom, "Not bottom edge")

		let bottom = evaluateExpression(subview.lexBottom == viewController.lexBottomLayoutGuide)
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Top, "Not top edge")
	}

	func testLayoutSupportExtensionLayoutGuides() {
		let top = evaluateExpression(subview.lexTop == viewController.topLayoutGuide.lexTop)
		XCTAssertTrue(top.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(top.secondItem === viewController.topLayoutGuide, "Wrong secondItem")
		XCTAssertTrue(top.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(top.secondAttribute == .Top, "Not top edge")

		let bottom = evaluateExpression(subview.lexBottom == viewController.bottomLayoutGuide.lexBottom)
		XCTAssertTrue(bottom.firstAttribute == .Bottom, "Not bottom edge")
		XCTAssertTrue(bottom.secondAttribute == .Bottom, "Not bottom edge")
	}
}
