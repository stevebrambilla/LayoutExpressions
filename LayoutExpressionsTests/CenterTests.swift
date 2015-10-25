//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class CenterTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testCenterToView() {
		let constraints = evaluateExpression(subview.lexCenter == container.lexCenter)

		let centerXs = constraints.filter { $0.firstAttribute == NSLayoutAttribute.CenterX }
		XCTAssertTrue(centerXs.count == 1, "Didn't find exactly one CenterX constraint.")
		if centerXs.count == 1 {
			let centerX = centerXs[0]
			XCTAssertTrue(centerX.secondAttribute == .CenterX, "Second attribute not CenterX")
			XCTAssertTrue(centerX.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(centerX.secondItem === container, "Wrong second item.")
		}

		let centerYs = constraints.filter { $0.firstAttribute == NSLayoutAttribute.CenterY }
		XCTAssertTrue(centerYs.count == 1, "Didn't find exactly one CenterX constraint.")
		if centerYs.count == 1 {
			let centerY = centerYs[0]
			XCTAssertTrue(centerY.secondAttribute == .CenterY, "Second attribute not CenterY")
			XCTAssertTrue(centerY.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(centerY.secondItem === container, "Wrong second item.")
		}
	}

	func testCenterToViewWithOffset() {
		let offset = PointOffset(horizontal: 5.0, vertical: -10.0)
		let constraints = evaluateExpression(subview.lexCenter == container.lexCenter + offset)

		validateConstraintConstants(constraints, x: 5.0, y: -10.0)
	}

	func testCenterToViewWithOffsetFromUIOffset() {
		let offset = UIOffset(horizontal: 5.0, vertical: -10.0)
		let constraints = evaluateExpression(subview.lexCenter == container.lexCenter + PointOffset(offset))

		validateConstraintConstants(constraints, x: 5.0, y: -10.0)
	}

	func validateConstraintConstants(constraints: [NSLayoutConstraint], x: CGFloat, y: CGFloat) {
		let centerXs = constraints.filter { $0.firstAttribute == NSLayoutAttribute.CenterX }
		XCTAssertTrue(centerXs.count == 1, "Didn't find exactly one CenterX constraint.")
		if centerXs.count == 1 {
			let centerX = centerXs[0]
			XCTAssertTrue(centerX.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(centerX.constant == x, "Wrong constant")
		}

		let centerYs = constraints.filter { $0.firstAttribute == NSLayoutAttribute.CenterY }
		XCTAssertTrue(centerYs.count == 1, "Didn't find exactly one CenterYconstraint.")
		if centerYs.count == 1 {
			let centerY = centerYs[0]
			XCTAssertTrue(centerY.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(centerY.constant == y, "Wrong constant")
		}
	}
}
