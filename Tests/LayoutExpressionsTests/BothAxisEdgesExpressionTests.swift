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

        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, second: container)

        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, second: container)

        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: subview, second: container)

        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: subview, second: container)
    }

    func testInsets() {
        let expression = (subview.anchors.allEdges == container.anchors.allEdges - 10)
        let constraints = expression.evaluateAll()

        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, second: container, constant: +10)

        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, second: container, constant: -10)

        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: subview, second: container, constant: +10)

        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: subview, second: container, constant: -10)
    }

    func testOutsets() {
         let expression = (subview.anchors.allEdges == container.anchors.allEdges + 10)
         let constraints = expression.evaluateAll()

         let top = extractSingleConstraint(constraints, withAttributes: .top)
         assertConstraint(top, first: subview, second: container, constant: -10)

         let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
         assertConstraint(bottom, first: subview, second: container, constant: +10)

         let leading = extractSingleConstraint(constraints, withAttributes: .leading)
         assertConstraint(leading, first: subview, second: container, constant: -10)

         let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
         assertConstraint(trailing, first: subview, second: container, constant: +10)
     }
}
