//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import Foundation

import XCTest

import LayoutExpressions

class SizeTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testSizeToView() {
		let constraints = evaluateLayoutExpression(subview.lexSize == container.lexSize)

		let widths = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Width }
		XCTAssertTrue(widths.count == 1, "Didn't find exactly one Width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssertTrue(width.secondAttribute == .Width, "Second attribute not Width")
			XCTAssertTrue(width.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(width.secondItem === container, "Wrong second item.")
		}

		let heights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Height }
		XCTAssertTrue(heights.count == 1, "Didn't find exactly one Height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssertTrue(height.secondAttribute == .Height, "Second attribute not Height")
			XCTAssertTrue(height.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(height.secondItem === container, "Wrong second item.")
		}
	}

	func testSizeToViewWithOffset() {
		let constraints = evaluateLayoutExpression(subview.lexSize == container.lexSize + SizeOffset(width: -20.0, height: -10.0))

		let widths = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Width }
		XCTAssertTrue(widths.count == 1, "Didn't find exactly one Width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssertTrue(width.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(width.constant == -20.0, "Wrong width constant.")
		}

		let heights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Height }
		XCTAssertTrue(heights.count == 1, "Didn't find exactly one Height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssertTrue(height.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(height.constant == -10.0, "Wrong height constant.")
		}
	}

	func testFixedSize() {
		let fixedSize = CGSize(width: 320.0, height: 400.0)
		let constraints = evaluateLayoutExpression(subview.lexSize == fixedSize)

		let widths = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Width }
		XCTAssertTrue(widths.count == 1, "Didn't find exactly one Width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssertTrue(width.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(width.constant == fixedSize.width, "Wrong width constant.")
		}

		let heights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Height }
		XCTAssertTrue(heights.count == 1, "Didn't find exactly one Height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssertTrue(height.multiplier == 1.0, "Wrong multiplier")
			XCTAssertTrue(height.constant == fixedSize.height, "Wrong height constant.")
		}
	}

	func testSizeOperators() {
		let equalsConstraints = evaluateLayoutExpression(subview.lexSize == container.lexSize)
		XCTAssertTrue(equalsConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(equalsConstraints[0].relation == NSLayoutRelation.Equal, "Wrong relation[0].")
		XCTAssertTrue(equalsConstraints[1].relation == NSLayoutRelation.Equal, "Wrong relation[1].")

		let lessThanConstraints = evaluateLayoutExpression(subview.lexSize <= container.lexSize)
		XCTAssertTrue(lessThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(lessThanConstraints[0].relation == NSLayoutRelation.LessThanOrEqual, "Wrong relation[0].")
		XCTAssertTrue(lessThanConstraints[1].relation == NSLayoutRelation.LessThanOrEqual, "Wrong relation[1].")

		let greaterThanConstraints = evaluateLayoutExpression(subview.lexSize >= container.lexSize)
		XCTAssertTrue(greaterThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(greaterThanConstraints[0].relation == NSLayoutRelation.GreaterThanOrEqual, "Wrong relation[0].")
		XCTAssertTrue(greaterThanConstraints[1].relation == NSLayoutRelation.GreaterThanOrEqual, "Wrong relation[1].")
	}

	func testFixedSizeOperators() {
		let fixedSize = CGSize(width: 320.0, height: 400.0)

		let equalsConstraints = evaluateLayoutExpression(subview.lexSize == fixedSize)
		XCTAssertTrue(equalsConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(equalsConstraints[0].relation == NSLayoutRelation.Equal, "Wrong relation[0].")
		XCTAssertTrue(equalsConstraints[1].relation == NSLayoutRelation.Equal, "Wrong relation[1].")

		let lessThanConstraints = evaluateLayoutExpression(subview.lexSize <= fixedSize)
		XCTAssertTrue(lessThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(lessThanConstraints[0].relation == NSLayoutRelation.LessThanOrEqual, "Wrong relation[0].")
		XCTAssertTrue(lessThanConstraints[1].relation == NSLayoutRelation.LessThanOrEqual, "Wrong relation[1].")

		let greaterThanConstraints = evaluateLayoutExpression(subview.lexSize >= fixedSize)
		XCTAssertTrue(greaterThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssertTrue(greaterThanConstraints[0].relation == NSLayoutRelation.GreaterThanOrEqual, "Wrong relation[0].")
		XCTAssertTrue(greaterThanConstraints[1].relation == NSLayoutRelation.GreaterThanOrEqual, "Wrong relation[1].")
	}
}
