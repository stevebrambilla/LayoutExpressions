//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest

@testable import LayoutExpressions

class EdgesExpressionTests: XCTestCase {

	var container = UIView()
	var subview = UIView()

	override func setUp() {
		super.setUp()

		container = UIView()
		subview = UIView()

		container.addSubview(subview)
	}

	func testEdges() {
		let containerAnchor = EdgesAnchor(topAnchor: container.topAnchor, leftAnchor: container.leftAnchor, bottomAnchor: container.bottomAnchor, rightAnchor: container.rightAnchor, insets: UndefinedInsets())
		let subviewAnchor = EdgesAnchor(topAnchor: subview.topAnchor, leftAnchor: subview.leftAnchor, bottomAnchor: subview.bottomAnchor, rightAnchor: subview.rightAnchor, insets: UndefinedInsets())

		let expression = (subviewAnchor == containerAnchor)
		let constraints = expression.evaluateAll()

		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssert(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssert(top.secondAttribute == .Top)
			XCTAssert(top.firstItem === subview)
			XCTAssert(top.secondItem === container)
		}

		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssert(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssert(left.secondAttribute == .Left)
			XCTAssert(left.firstItem === subview)
			XCTAssert(left.secondItem === container)
		}

		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssert(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssert(bottom.secondAttribute == .Bottom)
			XCTAssert(bottom.firstItem === subview)
			XCTAssert(bottom.secondItem === container)
		}

		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssert(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssert(right.secondAttribute == .Right)
			XCTAssert(right.firstItem === subview)
			XCTAssert(right.secondItem === container)
		}
	}

	func testVariableInsets() {
		let containerAnchor = EdgesAnchor(topAnchor: container.topAnchor, leftAnchor: container.leftAnchor, bottomAnchor: container.bottomAnchor, rightAnchor: container.rightAnchor, insets: UndefinedInsets())
		let subviewAnchor = EdgesAnchor(topAnchor: subview.topAnchor, leftAnchor: subview.leftAnchor, bottomAnchor: subview.bottomAnchor, rightAnchor: subview.rightAnchor, insets: UndefinedInsets())

		let insets = Insets(top: 1.0, left: 2.0, bottom: 3.0, right: 4.0)
		let expression = (subviewAnchor == containerAnchor - insets)
		let constraints = expression.evaluateAll()
		
		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssert(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssert(top.constant == 1.0)
			XCTAssert(top.multiplier == 1.0)
		}
		
		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssert(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssert(left.constant == 2.0)
			XCTAssert(left.multiplier == 1.0)
		}
		
		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssert(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssert(bottom.constant == -3.0)
			XCTAssert(bottom.multiplier == 1.0)
		}
		
		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssert(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssert(right.constant == -4.0)
			XCTAssert(right.multiplier == 1.0)
		}
	}
	
	func testEqualInsets() {
		let containerAnchor = EdgesAnchor(topAnchor: container.topAnchor, leftAnchor: container.leftAnchor, bottomAnchor: container.bottomAnchor, rightAnchor: container.rightAnchor, insets: UndefinedInsets())
		let subviewAnchor = EdgesAnchor(topAnchor: subview.topAnchor, leftAnchor: subview.leftAnchor, bottomAnchor: subview.bottomAnchor, rightAnchor: subview.rightAnchor, insets: UndefinedInsets())

		let expression = (subviewAnchor == containerAnchor - 10)
		let constraints = expression.evaluateAll()
		
		let tops = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Top }
		XCTAssert(tops.count == 1, "Didn't find exactly one Top constraint.")
		if tops.count == 1 {
			let top = tops[0]
			XCTAssert(top.constant == 10.0)
			XCTAssert(top.multiplier == 1.0)
		}
		
		let lefts = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Left }
		XCTAssert(lefts.count == 1, "Didn't find exactly one Left constraint.")
		if lefts.count == 1 {
			let left = lefts[0]
			XCTAssert(left.constant == 10.0)
			XCTAssert(left.multiplier == 1.0)
		}
		
		let bottoms = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Bottom }
		XCTAssert(bottoms.count == 1, "Didn't find exactly one Bottom constraint.")
		if bottoms.count == 1 {
			let bottom = bottoms[0]
			XCTAssert(bottom.constant == -10.0)
			XCTAssert(bottom.multiplier == 1.0)
		}
		
		let rights = constraints.filter { $0.firstAttribute == NSLayoutAttribute.Right }
		XCTAssert(rights.count == 1, "Didn't find exactly one Right constraint.")
		if rights.count == 1 {
			let right = rights[0]
			XCTAssert(right.constant == -10.0)
			XCTAssert(right.multiplier == 1.0)
		}
	}

	/*
	func testAddingExpressionToView() {
		let constraints = container.addLayoutExpression(subview.lexEdges == container.lexEdges - 10.0)
		XCTAssert(constraints.count == 4, "Didn't return exactly four constraints.")
		
		for c in constraints {
			XCTAssert((container.constraints as NSArray).containsObject(c), "Constraint not added to subview")
		}
	}
*/
}
