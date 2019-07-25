//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import XCTest
@testable import LayoutExpressions

class CenterExpressionsTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testCenterToView() {
		let expression = (subview.anchors.center == container.anchors.center)
		let constraints = expression.evaluateAll()
        
        let centerX = extractSingleConstraint(constraints, withAttributes: .centerX)
        assertConstraint(centerX, first: subview, relation: .equal, second: container)
        
        let centerY = extractSingleConstraint(constraints, withAttributes: .centerY)
        assertConstraint(centerY, first: subview, relation: .equal, second: container)
	}

	func testCenterToViewWithOffset() {
		let offset = Offset(horizontal: 5.0, vertical: -10.0)
		let expression = (subview.anchors.center == container.anchors.center + offset)
		let constraints = expression.evaluateAll()
        
        let centerX = extractSingleConstraint(constraints, withAttributes: .centerX)
        assertConstraint(centerX, first: subview, relation: .equal, second: container, constant: 5)
        
        let centerY = extractSingleConstraint(constraints, withAttributes: .centerY)
        assertConstraint(centerY, first: subview, relation: .equal, second: container, constant: -10)
	}

#if canImport(UIKit)
	func testCenterToViewWithOffsetFromUIOffset() {
		let offset = UIOffset(horizontal: 5.0, vertical: -10.0)
		let expression = (subview.anchors.center == container.anchors.center + offset)
		let constraints = expression.evaluateAll()

        let centerX = extractSingleConstraint(constraints, withAttributes: .centerX)
        assertConstraint(centerX, first: subview, relation: .equal, second: container, constant: 5)
        
        let centerY = extractSingleConstraint(constraints, withAttributes: .centerY)
        assertConstraint(centerY, first: subview, relation: .equal, second: container, constant: -10)
	}
#endif
}
