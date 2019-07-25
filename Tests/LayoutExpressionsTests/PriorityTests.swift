//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class PriorityTests: XCTestCase {

    var container = View()
    var subview = View()

    override func setUp() {
        super.setUp()

        container = View()
        subview = View()

        container.addSubview(subview)
    }

    func testCustomFloatPriority() {
        let constraint = Constraint.evaluate(subview.anchors.top == container.anchors.top <<~ 950.0)
        XCTAssert(constraint.priority.rawValue == 950.0)
    }

    func testCustomIntPriority() {
        let constraint = Constraint.evaluate(subview.anchors.top == container.anchors.top <<~ 950)
        XCTAssert(constraint.priority.rawValue == 950)
    }

    func testSystemPriority() {
        let constraint = Constraint.evaluate(subview.anchors.top == container.anchors.top <<~ .defaultHigh)
        XCTAssert(constraint.priority.rawValue == 750, "Wrong priority")
    }

    func testOffsetPriority() {
        let almostRequired = Constraint.evaluate(subview.anchors.top == container.anchors.top <<~ .required - 1)
        XCTAssert(almostRequired.priority.rawValue == 999)

        let niceToHave = Constraint.evaluate(subview.anchors.top == container.anchors.top <<~ 100 - 1)
        XCTAssert(niceToHave.priority.rawValue == 99)
    }
}
