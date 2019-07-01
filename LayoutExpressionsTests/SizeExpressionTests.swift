//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import Foundation

import XCTest

@testable import LayoutExpressions

class SizeExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testSizeToView() {
		let containerAnchor = SizeAnchor(widthAnchor: container.widthAnchor, heightAnchor: container.heightAnchor, size: UndefinedSize())
		let subviewAnchor = SizeAnchor(widthAnchor: subview.widthAnchor, heightAnchor: subview.heightAnchor, size: UndefinedSize())

		let expression = (subviewAnchor == containerAnchor)
		let constraints = expression.evaluateAll()

		let widths = constraints.filter { $0.firstAttribute == .width }
		XCTAssert(widths.count == 1, "Didn't find exactly one .width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssert(width.secondAttribute == .width)
			XCTAssert(width.firstItem === subview)
			XCTAssert(width.secondItem === container)
		}

		let heights = constraints.filter { $0.firstAttribute == .height }
		XCTAssert(heights.count == 1, "Didn't find exactly one .height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssert(height.secondAttribute == .height)
			XCTAssert(height.firstItem === subview)
			XCTAssert(height.secondItem === container)
		}
	}

	func testSizeToViewWithOffset() {
		let containerAnchor = SizeAnchor(widthAnchor: container.widthAnchor, heightAnchor: container.heightAnchor, size: UndefinedSize())
		let subviewAnchor = SizeAnchor(widthAnchor: subview.widthAnchor, heightAnchor: subview.heightAnchor, size: UndefinedSize())

		let expression = (subviewAnchor == containerAnchor + Size(width: -20, height: -10))
		let constraints = expression.evaluateAll()

		let widths = constraints.filter { $0.firstAttribute == .width }
		XCTAssert(widths.count == 1, "Didn't find exactly one .width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssert(width.multiplier == 1)
			XCTAssert(width.constant == -20)
		}

		let heights = constraints.filter { $0.firstAttribute == .height }
		XCTAssert(heights.count == 1, "Didn't find exactly one .height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssert(height.multiplier == 1)
			XCTAssert(height.constant == -10)
		}
	}

	func testFixedSize() {
		let subviewAnchor = SizeAnchor(widthAnchor: subview.widthAnchor, heightAnchor: subview.heightAnchor, size: UndefinedSize())

		let expression = (subviewAnchor == Size(width: 320, height: 400))
		let constraints = expression.evaluateAll()

		let widths = constraints.filter { $0.firstAttribute == .width }
		XCTAssert(widths.count == 1, "Didn't find exactly one .width constraint.")
		if widths.count == 1 {
			let width = widths[0]
			XCTAssert(width.multiplier == 1)
			XCTAssert(width.constant == 320)
		}

		let heights = constraints.filter { $0.firstAttribute == .height }
		XCTAssert(heights.count == 1, "Didn't find exactly one .height constraint.")
		if heights.count == 1 {
			let height = heights[0]
			XCTAssert(height.multiplier == 1)
			XCTAssert(height.constant == 400)
		}
	}

	func testSizeOperators() {
		let containerAnchor = SizeAnchor(widthAnchor: container.widthAnchor, heightAnchor: container.heightAnchor, size: UndefinedSize())
		let subviewAnchor = SizeAnchor(widthAnchor: subview.widthAnchor, heightAnchor: subview.heightAnchor, size: UndefinedSize())

		let equalsConstraints = evaluateLayoutExpression(subviewAnchor == containerAnchor)
		XCTAssert(equalsConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(equalsConstraints[0].relation == .equal)
		XCTAssert(equalsConstraints[1].relation == .equal)

		let lessThanConstraints = evaluateLayoutExpression(subviewAnchor <= containerAnchor)
		XCTAssert(lessThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(lessThanConstraints[0].relation == .lessThanOrEqual)
		XCTAssert(lessThanConstraints[1].relation == .lessThanOrEqual)

		let greaterThanConstraints = evaluateLayoutExpression(subviewAnchor >= containerAnchor)
		XCTAssert(greaterThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(greaterThanConstraints[0].relation == .greaterThanOrEqual)
		XCTAssert(greaterThanConstraints[1].relation == .greaterThanOrEqual)
	}

	func testFixedSizeOperators() {
		let subviewAnchor = SizeAnchor(widthAnchor: subview.widthAnchor, heightAnchor: subview.heightAnchor, size: UndefinedSize())

		let fixedSize = Size(width: 320.0, height: 400.0)

		let equalsConstraints = evaluateLayoutExpression(subviewAnchor == fixedSize)
		XCTAssert(equalsConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(equalsConstraints[0].relation == .equal)
		XCTAssert(equalsConstraints[1].relation == .equal)

		let lessThanConstraints = evaluateLayoutExpression(subviewAnchor <= fixedSize)
		XCTAssert(lessThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(lessThanConstraints[0].relation == .lessThanOrEqual)
		XCTAssert(lessThanConstraints[1].relation == .lessThanOrEqual)

		let greaterThanConstraints = evaluateLayoutExpression(subviewAnchor >= fixedSize)
		XCTAssert(greaterThanConstraints.count == 2, "Didn't find exactly two constraints.")
		XCTAssert(greaterThanConstraints[0].relation == .greaterThanOrEqual)
		XCTAssert(greaterThanConstraints[1].relation == .greaterThanOrEqual)
	}
}
