//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

@testable import LayoutExpressions
import XCTest

class DimensionExpressionTests: XCTestCase {

    var container = View()
    var subview = View()

    override func setUp() {
        super.setUp()

        container = View()
        subview = View()

        container.addSubview(subview)
    }

    func testDimensionExpressionWithoutMultiplierOrConstant() {
        let expression = (subview.anchors.height == container.anchors.width)
        let constraint = expression.evaluateDistinct()

        assertConstraint(constraint, first: subview, .height, relation: .equal, second: container, .width, multiplier: 1, constant: 0)
    }

    func testDimensionExpressionWithConstant() {
        let expression = (subview.anchors.height == container.anchors.width + 10)
        let constraint = expression.evaluateDistinct()

        assertConstraint(constraint, first: subview, .height, relation: .equal, second: container, .width, multiplier: 1, constant: 10)
    }

    func testDimensionExpressionWithMultiplier() {
        let expression = (subview.anchors.height == container.anchors.width * 2)
        let constraint = expression.evaluateDistinct()

        assertConstraint(constraint, first: subview, .height, relation: .equal, second: container, .width, multiplier: 2, constant: 0)
    }

    func testDimensionExpressionWithMultiplierAndConstant() {
        let expression = (subview.anchors.height == container.anchors.width * 2 + 10)
        let constraint = expression.evaluateDistinct()

        assertConstraint(constraint, first: subview, .height, relation: .equal, second: container, .width, multiplier: 2, constant: 10)
    }

    func testDimensionRelations() {
        let ltExpression = (subview.anchors.height <= container.anchors.width * 2 + 10)
        let ltConstraint = ltExpression.evaluateDistinct()
        assertConstraint(ltConstraint, first: subview, .height, relation: .lessThanOrEqual, second: container, .width, multiplier: 2, constant: 10)

        let eqExpression = (subview.anchors.height == container.anchors.width * 2 + 10)
        let eqConstraint = eqExpression.evaluateDistinct()
        assertConstraint(eqConstraint, first: subview, .height, relation: .equal, second: container, .width, multiplier: 2, constant: 10)

        let gtExpression = (subview.anchors.height >= container.anchors.width * 2 + 10)
        let gtConstraint = gtExpression.evaluateDistinct()
        assertConstraint(gtConstraint, first: subview, .height, relation: .greaterThanOrEqual, second: container, .width, multiplier: 2, constant: 10)
    }
}
