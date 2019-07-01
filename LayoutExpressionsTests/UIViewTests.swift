//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

// TODO: Should this use the View typealias and work on both platforms?

class UIViewTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testYAxis() {
		let topAndBottom = evaluateLayoutExpression(subview.anchors.top == container.anchors.bottom)
		XCTAssert(topAndBottom.firstItem === subview)
		XCTAssert(topAndBottom.secondItem === container)
		XCTAssert(topAndBottom.firstAttribute == .top)
		XCTAssert(topAndBottom.secondAttribute == .bottom)

		let centerY = evaluateLayoutExpression(subview.anchors.centerY == container.anchors.centerY)
		XCTAssert(centerY.firstAttribute == .centerY)
		XCTAssert(centerY.secondAttribute == .centerY)
	}

	func testXAxis() {
		let leftAndRight = evaluateLayoutExpression(subview.anchors.left == container.anchors.right)
		XCTAssert(leftAndRight.firstAttribute == .left)
		XCTAssert(leftAndRight.secondAttribute == .right)

		let leadingAndTrailing = evaluateLayoutExpression(subview.anchors.leading == container.anchors.trailing)
		XCTAssert(leadingAndTrailing.firstAttribute == .leading)
		XCTAssert(leadingAndTrailing.secondAttribute == .trailing)

		let centerX = evaluateLayoutExpression(subview.anchors.centerX == container.anchors.centerX)
		XCTAssert(centerX.firstAttribute == .centerX)
		XCTAssert(centerX.secondAttribute == .centerX)
	}

	func testDimensions() {
		let width = evaluateLayoutExpression(subview.anchors.width == container.anchors.width)
		XCTAssert(width.firstAttribute == .width)
		XCTAssert(width.secondAttribute == .width)

		let height = evaluateLayoutExpression(subview.anchors.height == container.anchors.height)
		XCTAssert(height.firstAttribute == .height)
		XCTAssert(height.secondAttribute == .height)
	}

	func testCenter() {
		let constraints = evaluateLayoutExpression(subview.anchors.center == container.anchors.center)
		XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

		let centerXs = constraints.filter { $0.firstAttribute == .centerX && $0.secondAttribute == .centerX }
		XCTAssert(centerXs.count == 1, "Didn't find exactly one CenterX constraint.")

		let centerYs = constraints.filter { $0.firstAttribute == .centerY && $0.secondAttribute == .centerY }
		XCTAssert(centerYs.count == 1, "Didn't find exactly one CenterY constraint.")
	}

	func testSize() {
		let constraints = evaluateLayoutExpression(subview.anchors.size == container.anchors.size)
		XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

		let widths = constraints.filter { $0.firstAttribute == .width && $0.secondAttribute == .width }
		XCTAssert(widths.count == 1, "Didn't find exactly one Width constraint.")

		let heights = constraints.filter { $0.firstAttribute == .height && $0.secondAttribute == .height }
		XCTAssert(heights.count == 1, "Didn't find exactly one Height constraint.")
	}

	func testEdges() {
		let constraints = evaluateLayoutExpression(subview.anchors.edges == container.anchors.edges)
		XCTAssert(constraints.count == 4, "Expected exactly 4 constraints")

		let tops = constraints.filter { $0.firstAttribute == .top && $0.secondAttribute == .top }
		XCTAssert(tops.count == 1, "Didn't find exactly one Top constraint.")

		let lefts = constraints.filter { $0.firstAttribute == .left && $0.secondAttribute == .left }
		XCTAssert(lefts.count == 1, "Didn't find exactly one Left constraint.")

		let bottoms = constraints.filter { $0.firstAttribute == .bottom && $0.secondAttribute == .bottom }
		XCTAssert(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")

		let rights = constraints.filter { $0.firstAttribute == .right && $0.secondAttribute == .right }
		XCTAssert(rights.count == 1, "Didn't find exactly one Right constraint.")
	}

	func testConstant() {
		let positive = evaluateLayoutExpression(subview.anchors.top == container.anchors.top + 15.0)
		XCTAssert(positive.constant == 15.0)

		let negative = evaluateLayoutExpression(subview.anchors.top == container.anchors.top - 15.0)
		XCTAssert(negative.constant == -15.0)
	}

	func testMultiplier() {
		let rhsConstraint = evaluateLayoutExpression(subview.anchors.width == container.anchors.width * 2)
		XCTAssert(rhsConstraint.multiplier == 2.0)

		let lhsConstraint = evaluateLayoutExpression(subview.anchors.width == 2 * container.anchors.width)
		XCTAssert(lhsConstraint.multiplier == 2.0)
	}

	func testConstantAndMultiplier() {
		let constraint = evaluateLayoutExpression(subview.anchors.width == container.anchors.width * 2 + 15.0)
		XCTAssert(constraint.constant == 15.0)
		XCTAssert(constraint.multiplier == 2.0)
	}

	func testAddingSingleExpressionToView() {
		let constraint = container.addLayoutExpression(subview.anchors.top == container.anchors.top)

		let results = container.constraints.filter { $0 === constraint }
		XCTAssert(results.count == 1, "Constraint not added")
	}

	func testAddingMultipleExpressionsToView() {
		_ = container.addLayoutExpressions(
			subview.anchors.top == container.anchors.top,
			subview.anchors.left == container.anchors.left,
			subview.anchors.bottom == container.anchors.bottom,
			subview.anchors.right == container.anchors.right
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}

	func testAddingMultipleTypesOfExpressionsToView() {
		_ = container.addLayoutExpressions(
			subview.anchors.top == container.anchors.top + 10,
			subview.anchors.width == container.anchors.width * 2,
			subview.anchors.center == container.anchors.center
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}

	func testAddingMultiplePriorityExpressionsToView() {
		_ = container.addLayoutExpressions(
			subview.anchors.top == container.anchors.top + 10 <<~ .defaultLow,
			subview.anchors.width == container.anchors.width * 2 <<~ .required,
			subview.anchors.center == container.anchors.center <<~ .defaultHigh
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}

	func testLayoutMarginsLayoutArea() {
		let top = evaluateLayoutExpression(subview.anchors.top == container.anchors.margins.top)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === container.layoutMarginsGuide)
		XCTAssert(top.firstAttribute == .top)
		XCTAssert(top.secondAttribute == .top)

		let left = evaluateLayoutExpression(subview.anchors.left == container.anchors.margins.left)
		XCTAssert(left.firstItem === subview)
		XCTAssert(left.secondItem === container.layoutMarginsGuide)
		XCTAssert(left.firstAttribute == .left)
		XCTAssert(left.secondAttribute == .left)

		let bottom = evaluateLayoutExpression(subview.anchors.bottom == container.anchors.margins.bottom)
		XCTAssert(bottom.firstItem === subview)
		XCTAssert(bottom.secondItem === container.layoutMarginsGuide)
		XCTAssert(bottom.firstAttribute == .bottom)
		XCTAssert(bottom.secondAttribute == .bottom)

		let right = evaluateLayoutExpression(subview.anchors.right == container.anchors.margins.right)
		XCTAssert(right.firstItem === subview)
		XCTAssert(right.secondItem === container.layoutMarginsGuide)
		XCTAssert(right.firstAttribute == .right)
		XCTAssert(right.secondAttribute == .right)
	}

	func testReadableContentLayoutArea() {
		let top = evaluateLayoutExpression(subview.anchors.top == container.anchors.readable.top)
		XCTAssert(top.firstItem === subview)
		XCTAssert(top.secondItem === container.readableContentGuide)
		XCTAssert(top.firstAttribute == .top)
		XCTAssert(top.secondAttribute == .top)

		let left = evaluateLayoutExpression(subview.anchors.left == container.anchors.readable.left)
		XCTAssert(left.firstItem === subview)
		XCTAssert(left.secondItem === container.readableContentGuide)
		XCTAssert(left.firstAttribute == .left)
		XCTAssert(left.secondAttribute == .left)

		let bottom = evaluateLayoutExpression(subview.anchors.bottom == container.anchors.readable.bottom)
		XCTAssert(bottom.firstItem === subview)
		XCTAssert(bottom.secondItem === container.readableContentGuide)
		XCTAssert(bottom.firstAttribute == .bottom)
		XCTAssert(bottom.secondAttribute == .bottom)

		let right = evaluateLayoutExpression(subview.anchors.right == container.anchors.readable.right)
		XCTAssert(right.firstItem === subview)
		XCTAssert(right.secondItem === container.readableContentGuide)
		XCTAssert(right.firstAttribute == .right)
		XCTAssert(right.secondAttribute == .right)
	}
}
