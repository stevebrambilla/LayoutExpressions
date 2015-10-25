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
		let topAndBottom = evaluateExpression(subview.lex_top == container.lex_bottom)
		XCTAssertTrue(topAndBottom.firstItem === subview, "Wrong firstItem")
		XCTAssertTrue(topAndBottom.secondItem === container, "Wrong secondItem")
		XCTAssertTrue(topAndBottom.firstAttribute == .Top, "Not top edge")
		XCTAssertTrue(topAndBottom.secondAttribute == .Bottom, "Not bottom edge")

		let leftAndRight = evaluateExpression(subview.lex_left == container.lex_right)
		XCTAssertTrue(leftAndRight.firstAttribute == .Left, "Not left edge")
		XCTAssertTrue(leftAndRight.secondAttribute == .Right, "Not right edge")

		let leadingAndTrailing = evaluateExpression(subview.lex_leading == container.lex_trailing)
		XCTAssertTrue(leadingAndTrailing.firstAttribute == .Leading, "Not leading edge")
		XCTAssertTrue(leadingAndTrailing.secondAttribute == .Trailing, "Not trailing edge")
	}

	func testCenter() {
		let centerX = evaluateExpression(subview.lex_centerX == container.lex_centerX)
		XCTAssertTrue(centerX.firstAttribute == .CenterX, "Not center X")
		XCTAssertTrue(centerX.secondAttribute == .CenterX, "Not center X")

		let centerY = evaluateExpression(subview.lex_centerY == container.lex_centerY)
		XCTAssertTrue(centerY.firstAttribute == .CenterY, "Not center Y")
		XCTAssertTrue(centerY.secondAttribute == .CenterY, "Not center Y")
	}

	func testBaseline() {
		let baseline = evaluateExpression(subview.lex_baseline == container.lex_baseline)
		XCTAssertTrue(baseline.firstAttribute == .Baseline, "Wrong attribute")
		XCTAssertTrue(baseline.secondAttribute == .Baseline, "Wrong attribute")
	}

	func testConstant() {
		let positive = evaluateExpression(subview.lex_top == container.lex_top + 15.0)
		XCTAssertTrue(positive.constant == 15.0, "Wrong constant")

		let negative = evaluateExpression(subview.lex_top == container.lex_top - 15.0)
		XCTAssertTrue(negative.constant == -15.0, "Wrong constant")
	}

	func testMultiplier() {
		let rhsConstraint = evaluateExpression(subview.lex_top == container.lex_top * 2)
		XCTAssertTrue(rhsConstraint.multiplier == 2.0, "Wrong multiplier")

		let lhsConstraint = evaluateExpression(subview.lex_top == 2 * container.lex_top)
		XCTAssertTrue(lhsConstraint.multiplier == 2.0, "Wrong multiplier")
	}

	func testConstantAndMultiplier() {
		let constraint = evaluateExpression(subview.lex_top == container.lex_top * 2 + 15.0)
		XCTAssertTrue(constraint.constant == 15.0, "Wrong constant")
		XCTAssertTrue(constraint.multiplier == 2.0, "Wrong multiplier")
	}

	func testAddingSingleExpressionToView() {
		let constraint = container.lex_addExpression(subview.lex_top == container.lex_top)

		let results = container.constraints.filter { $0 === constraint }
		XCTAssertTrue(results.count == 1, "Constraint not added")
	}

	func testAddingMultipleExpressionsToView() {
		let constraints = container.lex_addExpressions(
			subview.lex_top == container.lex_top,
			subview.lex_left == container.lex_left,
			subview.lex_bottom == container.lex_bottom,
			subview.lex_right == container.lex_right
		)
		XCTAssertTrue(container.constraints.count == 4, "Expected exactly 4 constraints")

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
