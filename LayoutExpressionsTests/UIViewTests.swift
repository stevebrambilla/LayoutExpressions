//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class UIViewTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testYAxis() {
		let topAndBottom = evaluateLayoutExpression(subview.lexTop == container.lexBottom)
		XCTAssert(topAndBottom.firstItem === subview)
		XCTAssert(topAndBottom.secondItem === container)
		XCTAssert(topAndBottom.firstAttribute == .Top)
		XCTAssert(topAndBottom.secondAttribute == .Bottom)

		let centerY = evaluateLayoutExpression(subview.lexCenterY == container.lexCenterY)
		XCTAssert(centerY.firstAttribute == .CenterY)
		XCTAssert(centerY.secondAttribute == .CenterY)
	}

	func testXAxis() {
		let leftAndRight = evaluateLayoutExpression(subview.lexLeft == container.lexRight)
		XCTAssert(leftAndRight.firstAttribute == .Left)
		XCTAssert(leftAndRight.secondAttribute == .Right)

		let leadingAndTrailing = evaluateLayoutExpression(subview.lexLeading == container.lexTrailing)
		XCTAssert(leadingAndTrailing.firstAttribute == .Leading)
		XCTAssert(leadingAndTrailing.secondAttribute == .Trailing)

		let centerX = evaluateLayoutExpression(subview.lexCenterX == container.lexCenterX)
		XCTAssert(centerX.firstAttribute == .CenterX)
		XCTAssert(centerX.secondAttribute == .CenterX)
	}

	func testDimensions() {
		let width = evaluateLayoutExpression(subview.lexWidth == container.lexWidth)
		XCTAssert(width.firstAttribute == .Width)
		XCTAssert(width.secondAttribute == .Width)

		let height = evaluateLayoutExpression(subview.lexHeight == container.lexHeight)
		XCTAssert(height.firstAttribute == .Height)
		XCTAssert(height.secondAttribute == .Height)
	}

	func testCenter() {
		let constraints = evaluateLayoutExpression(subview.lexCenter == container.lexCenter)
		XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

		let centerXs = constraints.filter { $0.firstAttribute == .CenterX && $0.secondAttribute == .CenterX }
		XCTAssert(centerXs.count == 1, "Didn't find exactly one CenterX constraint.")

		let centerYs = constraints.filter { $0.firstAttribute == .CenterY && $0.secondAttribute == .CenterY }
		XCTAssert(centerYs.count == 1, "Didn't find exactly one CenterY constraint.")
	}

	func testSize() {
		let constraints = evaluateLayoutExpression(subview.lexSize == container.lexSize)
		XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

		let widths = constraints.filter { $0.firstAttribute == .Width && $0.secondAttribute == .Width }
		XCTAssert(widths.count == 1, "Didn't find exactly one Width constraint.")

		let heights = constraints.filter { $0.firstAttribute == .Height && $0.secondAttribute == .Height }
		XCTAssert(heights.count == 1, "Didn't find exactly one Height constraint.")
	}

	func testEdges() {
		let constraints = evaluateLayoutExpression(subview.lexEdges == container.lexEdges)
		XCTAssert(constraints.count == 4, "Expected exactly 4 constraints")

		let tops = constraints.filter { $0.firstAttribute == .Top && $0.secondAttribute == .Top }
		XCTAssert(tops.count == 1, "Didn't find exactly one Top constraint.")

		let lefts = constraints.filter { $0.firstAttribute == .Left && $0.secondAttribute == .Left }
		XCTAssert(lefts.count == 1, "Didn't find exactly one Left constraint.")

		let bottoms = constraints.filter { $0.firstAttribute == .Bottom && $0.secondAttribute == .Bottom }
		XCTAssert(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")

		let rights = constraints.filter { $0.firstAttribute == .Right && $0.secondAttribute == .Right }
		XCTAssert(rights.count == 1, "Didn't find exactly one Right constraint.")
	}

	func testConstant() {
		let positive = evaluateLayoutExpression(subview.lexTop == container.lexTop + 15.0)
		XCTAssert(positive.constant == 15.0)

		let negative = evaluateLayoutExpression(subview.lexTop == container.lexTop - 15.0)
		XCTAssert(negative.constant == -15.0)
	}

	func testMultiplier() {
		let rhsConstraint = evaluateLayoutExpression(subview.lexWidth == container.lexWidth * 2)
		XCTAssert(rhsConstraint.multiplier == 2.0)

		let lhsConstraint = evaluateLayoutExpression(subview.lexWidth == 2 * container.lexWidth)
		XCTAssert(lhsConstraint.multiplier == 2.0)
	}

	func testConstantAndMultiplier() {
		let constraint = evaluateLayoutExpression(subview.lexWidth == container.lexWidth * 2 + 15.0)
		XCTAssert(constraint.constant == 15.0)
		XCTAssert(constraint.multiplier == 2.0)
	}

	func testAddingSingleExpressionToView() {
		let constraint = container.addLayoutExpression(subview.lexTop == container.lexTop)

		let results = container.constraints.filter { $0 === constraint }
		XCTAssert(results.count == 1, "Constraint not added")
	}

	func testAddingMultipleExpressionsToView() {
		container.addLayoutExpressions(
			subview.lexTop == container.lexTop,
			subview.lexLeft == container.lexLeft,
			subview.lexBottom == container.lexBottom,
			subview.lexRight == container.lexRight
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}

	func testAddingMultipleTypesOfExpressionsToView() {
		container.addLayoutExpressions(
			subview.lexTop == container.lexTop + 10,
			subview.lexWidth == container.lexWidth * 2,
			subview.lexCenter == container.lexCenter
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}

	func testAddingMultiplePriorityExpressionsToView() {
		container.addLayoutExpressions(
			subview.lexTop == container.lexTop + 10 <~ .DefaultLow,
			subview.lexWidth == container.lexWidth * 2 <~ .Required,
			subview.lexCenter == container.lexCenter <~ .DefaultHigh
		)
		XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
	}
}
