//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import LayoutExpressions
import XCTest

class ViewTests: XCTestCase {

    var container = View()
    var subview = View()

    override func setUp() {
        super.setUp()

        container = View()
        subview = View()

        container.addSubview(subview)
    }

    func testYAxis() {
        let topAndBottom = Constraint.evaluate(subview.anchors.top == container.anchors.bottom)
        assertConstraint(topAndBottom, first: subview, .top, relation: .equal, second: container, .bottom)

        let centerY = Constraint.evaluate(subview.anchors.centerY == container.anchors.centerY)
        assertConstraint(centerY, first: subview, .centerY, relation: .equal, second: container, .centerY)
    }

    func testXAxis() {
        let leftAndRight = Constraint.evaluate(subview.anchors.left == container.anchors.right)
        assertConstraint(leftAndRight, first: subview, .left, relation: .equal, second: container, .right)

        let leadingAndTrailing = Constraint.evaluate(subview.anchors.leading == container.anchors.trailing)
        assertConstraint(leadingAndTrailing, first: subview, .leading, relation: .equal, second: container, .trailing)

        let centerX = Constraint.evaluate(subview.anchors.centerX == container.anchors.centerX)
        assertConstraint(centerX, first: subview, .centerX, relation: .equal, second: container, .centerX)
    }

    func testDimensions() {
        let width = Constraint.evaluate(subview.anchors.width == container.anchors.width)
        assertConstraint(width, first: subview, .width, relation: .equal, second: container, .width)

        let height = Constraint.evaluate(subview.anchors.height == container.anchors.height)
        assertConstraint(height, first: subview, .height, relation: .equal, second: container, .height)
    }

    func testCenter() {
        let constraints = Constraint.evaluate(subview.anchors.center == container.anchors.center)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

        let centerX = extractSingleConstraint(constraints, withAttributes: .centerX)
        assertConstraint(centerX, first: subview, .centerX, relation: .equal, second: container, .centerX)

        let centerY = extractSingleConstraint(constraints, withAttributes: .centerY)
        assertConstraint(centerY, first: subview, .centerY, relation: .equal, second: container, .centerY)
    }

    func testSize() {
        let constraints = Constraint.evaluate(subview.anchors.size == container.anchors.size)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

        let width = extractSingleConstraint(constraints, withAttributes: .width)
        assertConstraint(width, first: subview, .width, relation: .equal, second: container, .width)

        let height = extractSingleConstraint(constraints, withAttributes: .height)
        assertConstraint(height, first: subview, .height, relation: .equal, second: container, .height)
    }

    func testAllEdges() {
        let constraints = Constraint.evaluate(subview.anchors.allEdges == container.anchors.allEdges)
        XCTAssert(constraints.count == 4, "Expected exactly 4 constraints")

        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, .top, relation: .equal, second: container, .top)

        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, .bottom, relation: .equal, second: container, .bottom)

        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: subview, .leading, relation: .equal, second: container, .leading)

        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: subview, .trailing, relation: .equal, second: container, .trailing)
    }

    func testVerticalEdges() {
        let constraints = Constraint.evaluate(subview.anchors.verticalEdges == container.anchors.verticalEdges)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: subview, .top, relation: .equal, second: container, .top)

        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: subview, .bottom, relation: .equal, second: container, .bottom)
    }

    func testHorizontalEdges() {
        let constraints = Constraint.evaluate(subview.anchors.horizontalEdges == container.anchors.horizontalEdges)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")

        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: subview, .leading, relation: .equal, second: container, .leading)

        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: subview, .trailing, relation: .equal, second: container, .trailing)
    }

    func testConstant() {
        let positive = Constraint.evaluate(subview.anchors.top == container.anchors.top + 15.0)
        assertConstraint(positive, first: subview, .top, relation: .equal, second: container, .top, constant: 15.0)

        let negative = Constraint.evaluate(subview.anchors.top == container.anchors.top - 15.0)
        assertConstraint(negative, first: subview, .top, relation: .equal, second: container, .top, constant: -15.0)
    }

    func testMultiplier() {
        let onRightSide = Constraint.evaluate(subview.anchors.width == container.anchors.width * 2)
        assertConstraint(onRightSide, first: subview, .width, relation: .equal, second: container, .width, multiplier: 2)

        let onLeftSide = Constraint.evaluate(subview.anchors.width == 2 * container.anchors.width)
        assertConstraint(onLeftSide, first: subview, .width, relation: .equal, second: container, .width, multiplier: 2)
    }

    func testConstantAndMultiplier() {
        let constraint = Constraint.evaluate(subview.anchors.width == container.anchors.width * 2 + 15.0)
        assertConstraint(constraint, first: subview, .width, relation: .equal, second: container, .width, multiplier: 2, constant: 15.0)
    }

    func testAddingSingleExpressionToView() {
        let constraint = container.addLayoutExpression(subview.anchors.top == container.anchors.top)

        let results = container.constraints.filter { $0 === constraint }
        XCTAssert(results.count == 1, "Constraint not added")
    }

    func testAddingMultipleExpressionsToView() {
        _ = container.addLayoutExpressions(
            subview.anchors.top == container.anchors.top,
            subview.anchors.bottom == container.anchors.bottom,
            subview.anchors.leading == container.anchors.leading,
            subview.anchors.trailing == container.anchors.trailing
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }

    func testAddingMultipleTypesOfExpressionsToView() {
        _ = container.addLayoutExpressions(
            subview.anchors.top == container.anchors.top + 10,
            subview.anchors.width == container.anchors.width * 2,
            subview.anchors.center == container.anchors.center
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }

    func testAddingMultiplePriorityExpressionsToView() {
        _ = container.addLayoutExpressions(
            subview.anchors.top == container.anchors.top + 10 <<~ .defaultLow,
            subview.anchors.width == container.anchors.width * 2 <<~ .required,
            subview.anchors.center == container.anchors.center <<~ .defaultHigh
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }
}
