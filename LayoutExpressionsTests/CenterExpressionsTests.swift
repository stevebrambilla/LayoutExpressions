//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

@testable import LayoutExpressions

class CenterExpressionsTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testCenterToView() {
		let containerAnchor = CenterAnchor(centerXAnchor: container.centerXAnchor, centerYAnchor: container.centerYAnchor, offset: UndefinedOffset())
		let subviewAnchor = CenterAnchor(centerXAnchor: subview.centerXAnchor, centerYAnchor: subview.centerYAnchor, offset: UndefinedOffset())

		let expression = (subviewAnchor == containerAnchor)
		let constraints = expression.evaluateAll()

		let centerXs = constraints.filter { $0.firstAttribute == .centerX }
		XCTAssertTrue(centerXs.count == 1, "Didn't find exactly one .centerX constraint.")
		if centerXs.count == 1 {
			let centerX = centerXs[0]
			XCTAssertTrue(centerX.secondAttribute == .centerX)
			XCTAssertTrue(centerX.firstItem === subview)
			XCTAssertTrue(centerX.secondItem === container)
		}

		let centerYs = constraints.filter { $0.firstAttribute == .centerY }
		XCTAssertTrue(centerYs.count == 1, "Didn't find exactly one .centerX constraint.")
		if centerYs.count == 1 {
			let centerY = centerYs[0]
			XCTAssertTrue(centerY.secondAttribute == .centerY)
			XCTAssertTrue(centerY.firstItem === subview)
			XCTAssertTrue(centerY.secondItem === container)
		}
	}

	func testCenterToViewWithOffset() {
		let containerAnchor = CenterAnchor(centerXAnchor: container.centerXAnchor, centerYAnchor: container.centerYAnchor, offset: UndefinedOffset())
		let subviewAnchor = CenterAnchor(centerXAnchor: subview.centerXAnchor, centerYAnchor: subview.centerYAnchor, offset: UndefinedOffset())

		let offset = Offset(horizontal: 5.0, vertical: -10.0)
		let expression = (subviewAnchor == containerAnchor + offset)
		let constraints = expression.evaluateAll()

		validateConstraintConstants(constraints, x: 5.0, y: -10.0)
	}

	func testCenterToViewWithOffsetFromUIOffset() {
		let containerAnchor = CenterAnchor(centerXAnchor: container.centerXAnchor, centerYAnchor: container.centerYAnchor, offset: UndefinedOffset())
		let subviewAnchor = CenterAnchor(centerXAnchor: subview.centerXAnchor, centerYAnchor: subview.centerYAnchor, offset: UndefinedOffset())

		let offset = UIOffset(horizontal: 5.0, vertical: -10.0)
		let expression = (subviewAnchor == containerAnchor + Offset(offset))
		let constraints = expression.evaluateAll()

		validateConstraintConstants(constraints, x: 5.0, y: -10.0)
	}

	func validateConstraintConstants(_ constraints: [NSLayoutConstraint], x: CGFloat, y: CGFloat) {
		let centerXs = constraints.filter { $0.firstAttribute == .centerX }
		XCTAssertTrue(centerXs.count == 1, "Didn't find exactly one .centerX constraint.")
		if centerXs.count == 1 {
			let centerX = centerXs[0]
			XCTAssertTrue(centerX.multiplier == 1.0)
			XCTAssertTrue(centerX.constant == x)
		}

		let centerYs = constraints.filter { $0.firstAttribute == .centerY }
		XCTAssertTrue(centerYs.count == 1, "Didn't find exactly one .centerY constraint.")
		if centerYs.count == 1 {
			let centerY = centerYs[0]
			XCTAssertTrue(centerY.multiplier == 1.0)
			XCTAssertTrue(centerY.constant == y)
		}
	}
}
