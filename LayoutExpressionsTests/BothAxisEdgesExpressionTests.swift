//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class BothAxisEdgesExpressionTests: XCTestCase {

	var container = View()
	var subview = View()

	override func setUp() {
		super.setUp()

		container = View()
		subview = View()

		container.addSubview(subview)
	}

	func testEdges() {
		let expression = (subview.anchors.allEdges == container.anchors.allEdges)
		let constraints = expression.evaluateAll()
        
        let top = unwrapSingleConstraint(constraints, withAttribute: .top)
        assertConstraint(top, first: subview, second: container)
        
        let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
        assertConstraint(bottom, first: subview, second: container)
        
        let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
        assertConstraint(leading, first: subview, second: container)
        
        let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
        assertConstraint(trailing, first: subview, second: container)
	}
	
	func testInsets() {
        let expression = (subview.anchors.allEdges == container.anchors.allEdges - 10)
        let constraints = expression.evaluateAll()
        
        let top = unwrapSingleConstraint(constraints, withAttribute: .top)
        assertConstraint(top, first: subview, second: container, constant: +10)
        
        let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
        assertConstraint(bottom, first: subview, second: container, constant: -10)
        
        let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
        assertConstraint(leading, first: subview, second: container, constant: +10)
        
        let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
        assertConstraint(trailing, first: subview, second: container, constant: -10)
	}
 
    func testOutsets() {
         let expression = (subview.anchors.allEdges == container.anchors.allEdges + 10)
         let constraints = expression.evaluateAll()
         
         let top = unwrapSingleConstraint(constraints, withAttribute: .top)
         assertConstraint(top, first: subview, second: container, constant: -10)
         
         let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
         assertConstraint(bottom, first: subview, second: container, constant: +10)
         
         let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
         assertConstraint(leading, first: subview, second: container, constant: -10)
         
         let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
         assertConstraint(trailing, first: subview, second: container, constant: +10)
     }
}
