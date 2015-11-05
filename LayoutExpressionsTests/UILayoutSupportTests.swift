//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class UILayoutSupportTests: XCTestCase {

	var viewController = UIViewController()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		viewController = UIViewController()
		subview = UIView()

		viewController.view.addSubview(subview)
	}

	func testViewControllerExtensionLayoutGuides() {
		let top = evaluateLayoutExpression(subview.lexTop == viewController.lexTopLayoutGuide)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === viewController.topLayoutGuide)
		XCTAssert(top.firstAttribute == .Top)
		XCTAssert(top.secondAttribute == .Bottom)

		let bottom = evaluateLayoutExpression(subview.lexBottom == viewController.lexBottomLayoutGuide)
		XCTAssert(bottom.firstAttribute == .Bottom)
		XCTAssert(bottom.secondAttribute == .Top)
	}

	func testLayoutSupportExtensionLayoutGuides() {
		let top = evaluateLayoutExpression(subview.lexTop == viewController.topLayoutGuide.lexTop)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === viewController.topLayoutGuide)
		XCTAssert(top.firstAttribute == .Top)
		XCTAssert(top.secondAttribute == .Top)

		let bottom = evaluateLayoutExpression(subview.lexBottom == viewController.bottomLayoutGuide.lexBottom)
		XCTAssert(bottom.firstAttribute == .Bottom)
		XCTAssert(bottom.secondAttribute == .Bottom)
	}
}
