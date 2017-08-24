//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class UIViewControllerTests: XCTestCase {

	var viewController = UIViewController()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		viewController = UIViewController()
		subview = UIView()

		viewController.view.addSubview(subview)
	}

	@available(iOS, deprecated: 11.0)
	@available(tvOS, deprecated: 11.0)
	func testViewControllerExtensionLayoutGuides() {
		let top = evaluateLayoutExpression(subview.anchors.top == viewController.anchors.top)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === viewController.topLayoutGuide)
		XCTAssert(top.firstAttribute == .top)
		XCTAssert(top.secondAttribute == .bottom)

		let bottom = evaluateLayoutExpression(subview.anchors.bottom == viewController.anchors.bottom)
		XCTAssert(bottom.firstAttribute == .bottom)
		XCTAssert(bottom.secondAttribute == .top)
	}
}
