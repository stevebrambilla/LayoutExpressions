//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

#if canImport(UIKit)

import LayoutExpressions
import UIKit
import XCTest

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
		let top = Constraint.evaluate(subview.anchors.top == viewController.anchors.top)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === viewController.topLayoutGuide)
		XCTAssert(top.firstAttribute == .top)
		XCTAssert(top.secondAttribute == .bottom)

		let bottom = Constraint.evaluate(subview.anchors.bottom == viewController.anchors.bottom)
		XCTAssert(bottom.firstAttribute == .bottom)
		XCTAssert(bottom.secondAttribute == .top)
	}
}

#endif
