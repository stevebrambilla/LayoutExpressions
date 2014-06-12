//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class BasicTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testEdges() {
		// TODO: Once generics support is ready, eliminate this array (since evaluateExpression can return just one constraint):
		let topAndBottomArray = evaluateExpression(subview.lex_top() == container.lex_bottom())
		let topAndBottom = topAndBottomArray[0]
		XCTAssertTrue(topAndBottom.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(topAndBottom.secondItem === container, "Wrong secondItem")
		XCTAssertTrue(topAndBottom.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(topAndBottom.secondAttribute == .Bottom, "Not bottom edge")

		let leftAndRightArray = evaluateExpression(subview.lex_left() == container.lex_right())
		let leftAndRight = leftAndRightArray[0]
		XCTAssertTrue(leftAndRight.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(leftAndRight.secondAttribute == .Right, "Not right edge")

		let leadingAndTrailingArray = evaluateExpression(subview.lex_leading() == container.lex_trailing())
		let leadingAndTrailing = leadingAndTrailingArray[0]
		XCTAssertTrue(leadingAndTrailing.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(leadingAndTrailing.secondAttribute == .Trailing, "Not trailing edge")
	}

	func testCenter() {
		let centerXArray = evaluateExpression(subview.lex_centerX() == container.lex_centerX())
		let centerX = centerXArray[0]
		XCTAssertTrue(centerX.firstAttribute == .CenterX, "Not center X")
		XCTAssertTrue(centerX.secondAttribute == .CenterX, "Not center X")

		let centerYArray = evaluateExpression(subview.lex_centerY() == container.lex_centerY())
		let centerY = centerYArray[0]
		XCTAssertTrue(centerY.firstAttribute == .CenterY, "Not center Y")
		XCTAssertTrue(centerY.secondAttribute == .CenterY, "Not center Y")
	}

	func testSize() {
		let heightArray = evaluateExpression(subview.lex_height() == 50.0)
		let height = heightArray[0]
		XCTAssertTrue(height.secondAttribute == .NotAnAttribute, "Wrong attribute")
		XCTAssertTrue(height.multiplier == 1.0, "Wrong multiplier")
		XCTAssertTrue(height.constant == 50.0, "Wrong constant")

		let widthArray = evaluateExpression(subview.lex_width() == 320.0)
		let width = widthArray[0]
		XCTAssertTrue(width.secondAttribute == .NotAnAttribute, "Wrong attribute")
		XCTAssertTrue(width.multiplier == 1.0, "Wrong multiplier")
		XCTAssertTrue(width.constant == 320.0, "Wrong constant")

		let equalHeightsArray = evaluateExpression(subview.lex_height() == container.lex_height())
		let equalHeights = equalHeightsArray[0]
		XCTAssertTrue(equalHeights.firstAttribute == .Height, "Wrong attribute")
		XCTAssertTrue(equalHeights.secondAttribute == .Height, "Wrong attribute")
		XCTAssertTrue(equalHeights.multiplier == 1.0, "Wrong multiplier")
		XCTAssertTrue(equalHeights.constant == 0.0, "Wrong constant")
	}

	func testBaseline() {
		let baselineArray = evaluateExpression(subview.lex_baseline() == container.lex_baseline())
		let baseline = baselineArray[0]
		XCTAssertTrue(baseline.firstAttribute == .Baseline, "Wrong attribute")
		XCTAssertTrue(baseline.secondAttribute == .Baseline, "Wrong attribute")
	}

	func testConstant() {
		let positiveArray = evaluateExpression(subview.lex_top() == container.lex_top() + 15.0)
		let positive = positiveArray[0]
		XCTAssertTrue(positive.constant == 15.0, "Wrong constant")

		let negativeArray = evaluateExpression(subview.lex_top() == container.lex_top() - 15.0)
		let negative = negativeArray[0]
		XCTAssertTrue(negative.constant == -15.0, "Wrong constant")
	}

	func testMultiplier() {
		let constraintArray = evaluateExpression(subview.lex_top() == container.lex_top() * 2)
		let constraint = constraintArray[0]
		XCTAssertTrue(constraint.multiplier == 2.0, "Wrong multiplier")
	}

	func testBasicConstantAndMultiplier() {
		let constraintArray = evaluateExpression(subview.lex_top() == container.lex_top() * 2 + 15.0)
		let constraint = constraintArray[0]
		XCTAssertTrue(constraint.constant == 15.0, "Wrong constant")
		XCTAssertTrue(constraint.multiplier == 2.0, "Wrong multiplier")
	}

	func testAddingSingleExpressionToView() {
		let constraintArray = container.lex_addExpression(subview.lex_top() == container.lex_top())
		let constraint = constraintArray[0]

		let results = container.constraints().filter { $0 === constraint }
		XCTAssertTrue(results.count == 1, "Constraint not added")
	}

	func testAddingMultipleExpressionsToView() {
		let constraints = container.lex_addExpressions(
			subview.lex_top() == container.lex_top(),
			subview.lex_left() == container.lex_left(),
			subview.lex_bottom() == container.lex_bottom(),
			subview.lex_right() == container.lex_right()
		)
		XCTAssertTrue(container.constraints().count == 4, "Expected exactly 4 constraints")

		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssertTrue(tops.count == 1, "Didn't find exactly one Top constraint.")

		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssertTrue(lefts.count == 1, "Didn't find exactly one Left constraint.")

		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssertTrue(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")

		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssertTrue(rights.count == 1, "Didn't find exactly one Right constraint.")
	}
}
