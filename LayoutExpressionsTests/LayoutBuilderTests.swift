//  Copyright © 2019 Steve Brambilla. All rights reserved.

import LayoutExpressions
import XCTest

class LayoutBuilderTests: XCTestCase {
    var container = View()
    var subview = View()
    
    override func setUp() {
        super.setUp()
        
        container = View()
        subview = View()
        
        container.addSubview(subview)
    }
    
    func testSingleExpression() {
        let constraints = evaluateLayout {
            subview.anchors.top == container.anchors.top
        }
        
        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, second: container)
    }
    
    func testMultipleExpressions() {
        let constraints = evaluateLayout {
            subview.anchors.top == container.anchors.top
            subview.anchors.bottom == container.anchors.bottom
        }
        
        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, second: container)
        
        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, second: container)
    }
    
    func testIfConditionTrue() {
        let pinToTop = true
        
        let constraints = evaluateLayout {
            if pinToTop {
                subview.anchors.top == container.anchors.top
            } else {
                subview.anchors.bottom == container.anchors.bottom
            }
        }
        
        XCTAssert(constraints.count == 1)
        
        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, second: container)
    }
    
    func testIfConditionFalse() {
        let pinToTop = false
        
        let constraints = evaluateLayout {
            if pinToTop {
                subview.anchors.top == container.anchors.top
            } else {
                subview.anchors.bottom == container.anchors.bottom
            }
        }
        
        XCTAssert(constraints.count == 1)
        
        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, second: container)
    }
    
    func testIfWithoutElse() {
        var pinToTop = true
        
        let constraintsShouldHaveOne = evaluateLayout {
            if pinToTop {
                subview.anchors.top == container.anchors.top
            }
        }
        XCTAssert(constraintsShouldHaveOne.count == 1)
        
        pinToTop = false
        
        let constraintsShouldBeEmpty = evaluateLayout {
            if pinToTop {
                subview.anchors.top == container.anchors.top
            }
        }
        XCTAssert(constraintsShouldBeEmpty.isEmpty)
    }
    
    func testMultiConditionIf() {
        let stringAttribute = "leading"
        
        let constraints = evaluateLayout {
            if stringAttribute == "top" {
                subview.anchors.top == container.anchors.top
            } else if stringAttribute == "leading" {
                subview.anchors.leading == container.anchors.leading
            } else {
                subview.anchors.bottom == container.anchors.bottom
            }
        }
        
        XCTAssert(constraints.count == 1)
        
        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: subview, second: container)
    }
}
