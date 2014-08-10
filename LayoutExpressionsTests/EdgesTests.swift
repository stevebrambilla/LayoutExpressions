//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

import LayoutExpressions

class EdgesTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testEdges() {
		let constraints = evaluateExpression(subview.lex_edges == container.lex_edges)

		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssertTrue(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssertTrue(top.secondAttribute == .Top, "Second attribute not Top")
			XCTAssertTrue(top.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(top.secondItem === container, "Wrong second item.")
		}

		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssertTrue(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssertTrue(left.secondAttribute == .Left, "Second attribute not Left")
			XCTAssertTrue(left.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(left.secondItem === container, "Wrong second item.")
		}

		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssertTrue(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssertTrue(bottom.secondAttribute == .Bottom, "Second attribute not Bottom")
			XCTAssertTrue(bottom.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(bottom.secondItem === container, "Wrong second item.")
		}

		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssertTrue(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssertTrue(right.secondAttribute == .Right, "Second attribute not Right")
			XCTAssertTrue(right.firstItem === subview, "Wrong first item.")
			XCTAssertTrue(right.secondItem === container, "Wrong second item.")
		}
	}

	func testVariableInsets() {
		let insets = EdgeInsets(top: 1.0, left: 2.0, bottom: 3.0, right: 4.0)
		let constraints = evaluateExpression(subview.lex_edges == container.lex_edges - insets)
		
		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssertTrue(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssertTrue(top.constant == 1.0, "Wrong top constant")
			XCTAssertTrue(top.multiplier == 1.0, "Wrong top multiplier.")
		}
		
		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssertTrue(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssertTrue(left.constant == 2.0, "Wrong left constant")
			XCTAssertTrue(left.multiplier == 1.0, "Wrong left multiplier.")
		}
		
		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssertTrue(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssertTrue(bottom.constant == -3.0, "Wrong bottom constant")
			XCTAssertTrue(bottom.multiplier == 1.0, "Wrong bottom multiplier.")
		}
		
		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssertTrue(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssertTrue(right.constant == -4.0, "Wrong right constant")
			XCTAssertTrue(right.multiplier == 1.0, "Wrong right multiplier.")
		}
	}
	
	func testEqualInsets() {
		let constraints = evaluateExpression(subview.lex_edges == container.lex_edges - 10.0)
		
		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssertTrue(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssertTrue(top.constant == 10.0, "Wrong top constant")
			XCTAssertTrue(top.multiplier == 1.0, "Wrong top multiplier.")
		}
		
		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssertTrue(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssertTrue(left.constant == 10.0, "Wrong left constant")
			XCTAssertTrue(left.multiplier == 1.0, "Wrong left multiplier.")
		}
		
		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssertTrue(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssertTrue(bottom.constant == -10.0, "Wrong bottom constant")
			XCTAssertTrue(bottom.multiplier == 1.0, "Wrong bottom multiplier.")
		}
		
		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssertTrue(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssertTrue(right.constant == -10.0, "Wrong right constant")
			XCTAssertTrue(right.multiplier == 1.0, "Wrong right multiplier.")
		}
	}

	func testInitializingInsetsFromUIEdgeInsets() {
		let insets = UIEdgeInsets(top: 1.0, left: 2.0, bottom: 3.0, right: 4.0)
		let constraints = evaluateExpression(subview.lex_edges == container.lex_edges - EdgeInsets(insets))

		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssertTrue(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			XCTAssertTrue(tops[0].constant == 1.0, "Wrong top constant")
		}

		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssertTrue(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			XCTAssertTrue(lefts[0].constant == 2.0, "Wrong left constant")
		}

		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssertTrue(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			XCTAssertTrue(bottoms[0].constant == -3.0, "Wrong bottom constant")
		}

		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssertTrue(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			XCTAssertTrue(rights[0].constant == -4.0, "Wrong right constant")
		}
	}

	func testAddingExpressionToView() {
		let constraints = container.lex_addExpression(subview.lex_edges == container.lex_edges - 10.0)
		XCTAssertTrue(constraints.count == 4, "Didn't return exactly four constraints.")
		
		for c in constraints {
			XCTAssertTrue((container.constraints() as NSArray).containsObject(c), "Constraint not added to subview")
		}
	}
}