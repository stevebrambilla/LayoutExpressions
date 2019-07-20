//  Copyright © 2019 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class SingleAxisEdgesExpressionTests: XCTestCase {
    var container = View()
    var subview = View()

    override func setUp() {
        super.setUp()

        container = View()
        subview = View()

        container.addSubview(subview)
    }

    func testHorizontalEdges() {
        let expression = (subview.anchors.horizontalEdges == container.anchors.horizontalEdges)
        let constraints = expression.evaluateAll()

        let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
        assertConstraint(leading, first: subview, second: container)
        
        let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
        assertConstraint(trailing, first: subview, second: container)
    }
    
    func testVerticalEdges() {
        let expression = (subview.anchors.verticalEdges == container.anchors.verticalEdges)
        let constraints = expression.evaluateAll()

        let top = unwrapSingleConstraint(constraints, withAttribute: .top)
        assertConstraint(top, first: subview, second: container)
        
        let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
        assertConstraint(bottom, first: subview, second: container)
    }
    
    func testHorizontalInsets() {
        let expression = (subview.anchors.horizontalEdges == container.anchors.horizontalEdges - 10)
        let constraints = expression.evaluateAll()

        let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
        assertConstraint(leading, first: subview, second: container, constant: +10)
        
        let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
        assertConstraint(trailing, first: subview, second: container, constant: -10)
    }
    
    func testHorizontalOutsets() {
        let expression = (subview.anchors.horizontalEdges == container.anchors.horizontalEdges + 10)
        let constraints = expression.evaluateAll()
        
        let leading = unwrapSingleConstraint(constraints, withAttribute: .leading)
        assertConstraint(leading, first: subview, second: container, constant: -10)
        
        let trailing = unwrapSingleConstraint(constraints, withAttribute: .trailing)
        assertConstraint(trailing, first: subview, second: container, constant: +10)
    }
    
    func testVerticalInsets() {
        let expression = (subview.anchors.verticalEdges == container.anchors.verticalEdges - 10)
        let constraints = expression.evaluateAll()

        let top = unwrapSingleConstraint(constraints, withAttribute: .top)
        assertConstraint(top, first: subview, second: container, constant: +10)
        
        let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
        assertConstraint(bottom, first: subview, second: container, constant: -10)
    }
    
    func testVerticalOutsets() {
        let expression = (subview.anchors.verticalEdges == container.anchors.verticalEdges + 10)
        let constraints = expression.evaluateAll()

        let top = unwrapSingleConstraint(constraints, withAttribute: .top)
        assertConstraint(top, first: subview, second: container, constant: -10)
        
        let bottom = unwrapSingleConstraint(constraints, withAttribute: .bottom)
        assertConstraint(bottom, first: subview, second: container, constant: +10)
    }
}
