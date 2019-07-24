//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import LayoutExpressions
import XCTest

class LayoutGuideTests: XCTestCase {

	var container = View()
	var guide = LayoutGuide()

	override func setUp() {
		super.setUp()

		container = View()
		guide = LayoutGuide()

		container.addLayoutGuide(guide)
	}
    
    func testYAxis() {
        let topAndBottom = evaluateLayoutExpression(guide.anchors.top == container.anchors.bottom)
        assertConstraint(topAndBottom, first: guide, .top, relation: .equal, second: container, .bottom)
        
        let centerY = evaluateLayoutExpression(guide.anchors.centerY == container.anchors.centerY)
        assertConstraint(centerY, first: guide, .centerY, relation: .equal, second: container, .centerY)
    }
    
    func testXAxis() {
        let leftAndRight = evaluateLayoutExpression(guide.anchors.left == container.anchors.right)
        assertConstraint(leftAndRight, first: guide, .left, relation: .equal, second: container, .right)
        
        let leadingAndTrailing = evaluateLayoutExpression(guide.anchors.leading == container.anchors.trailing)
        assertConstraint(leadingAndTrailing, first: guide, .leading, relation: .equal, second: container, .trailing)
        
        let centerX = evaluateLayoutExpression(guide.anchors.centerX == container.anchors.centerX)
        assertConstraint(centerX, first: guide, .centerX, relation: .equal, second: container, .centerX)
    }
    
    func testDimensions() {
        let width = evaluateLayoutExpression(guide.anchors.width == container.anchors.width)
        assertConstraint(width, first: guide, .width, relation: .equal, second: container, .width)
        
        let height = evaluateLayoutExpression(guide.anchors.height == container.anchors.height)
        assertConstraint(height, first: guide, .height, relation: .equal, second: container, .height)
    }
    
    func testCenter() {
        let constraints = evaluateLayoutExpression(guide.anchors.center == container.anchors.center)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")
        
        let centerX = extractSingleConstraint(constraints, withAttributes: .centerX)
        assertConstraint(centerX, first: guide, .centerX, relation: .equal, second: container, .centerX)
        
        let centerY = extractSingleConstraint(constraints, withAttributes: .centerY)
        assertConstraint(centerY, first: guide, .centerY, relation: .equal, second: container, .centerY)
    }
    
    func testSize() {
        let constraints = evaluateLayoutExpression(guide.anchors.size == container.anchors.size)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")
        
        let width = extractSingleConstraint(constraints, withAttributes: .width)
        assertConstraint(width, first: guide, .width, relation: .equal, second: container, .width)
        
        let height = extractSingleConstraint(constraints, withAttributes: .height)
        assertConstraint(height, first: guide, .height, relation: .equal, second: container, .height)
    }
    
    func testAllEdges() {
        let constraints = evaluateLayoutExpression(guide.anchors.allEdges == container.anchors.allEdges)
        XCTAssert(constraints.count == 4, "Expected exactly 4 constraints")
        
        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: guide, .top, relation: .equal, second: container, .top)
        
        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: guide, .bottom, relation: .equal, second: container, .bottom)
        
        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: guide, .leading, relation: .equal, second: container, .leading)
        
        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: guide, .trailing, relation: .equal, second: container, .trailing)
    }
    
    func testVerticalEdges() {
        let constraints = evaluateLayoutExpression(guide.anchors.verticalEdges == container.anchors.verticalEdges)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")
        
        let top = extractSingleConstraint(constraints, withAttributes: .top)
        assertConstraint(top, first: guide, .top, relation: .equal, second: container, .top)
        
        let bottom = extractSingleConstraint(constraints, withAttributes: .bottom)
        assertConstraint(bottom, first: guide, .bottom, relation: .equal, second: container, .bottom)
    }
    
    func testHorizontalEdges() {
        let constraints = evaluateLayoutExpression(guide.anchors.horizontalEdges == container.anchors.horizontalEdges)
        XCTAssert(constraints.count == 2, "Expected exactly 2 constraints")
        
        let leading = extractSingleConstraint(constraints, withAttributes: .leading)
        assertConstraint(leading, first: guide, .leading, relation: .equal, second: container, .leading)
        
        let trailing = extractSingleConstraint(constraints, withAttributes: .trailing)
        assertConstraint(trailing, first: guide, .trailing, relation: .equal, second: container, .trailing)
    }
    
    func testConstant() {
        let positive = evaluateLayoutExpression(guide.anchors.top == container.anchors.top + 15.0)
        assertConstraint(positive, first: guide, .top, relation: .equal, second: container, .top, constant: 15.0)
        
        let negative = evaluateLayoutExpression(guide.anchors.top == container.anchors.top - 15.0)
        assertConstraint(negative, first: guide, .top, relation: .equal, second: container, .top, constant: -15.0)
    }
    
    func testMultiplier() {
        let onRightSide = evaluateLayoutExpression(guide.anchors.width == container.anchors.width * 2)
        assertConstraint(onRightSide, first: guide, .width, relation: .equal, second: container, .width, multiplier: 2)
        
        let onLeftSide = evaluateLayoutExpression(guide.anchors.width == 2 * container.anchors.width)
        assertConstraint(onLeftSide, first: guide, .width, relation: .equal, second: container, .width, multiplier: 2)
    }
    
    func testConstantAndMultiplier() {
        let constraint = evaluateLayoutExpression(guide.anchors.width == container.anchors.width * 2 + 15.0)
        assertConstraint(constraint, first: guide, .width, relation: .equal, second: container, .width, multiplier: 2, constant: 15.0)
    }
    
    func testAddingSingleExpressionToView() {
        let constraint = container.addLayoutExpression(guide.anchors.top == container.anchors.top)
        
        let results = container.constraints.filter { $0 === constraint }
        XCTAssert(results.count == 1, "Constraint not added")
    }
    
    func testAddingMultipleExpressionsToView() {
        _ = container.addLayoutExpressions(
            guide.anchors.top == container.anchors.top,
            guide.anchors.bottom == container.anchors.bottom,
            guide.anchors.leading == container.anchors.leading,
            guide.anchors.trailing == container.anchors.trailing
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }
    
    func testAddingMultipleTypesOfExpressionsToView() {
        _ = container.addLayoutExpressions(
            guide.anchors.top == container.anchors.top + 10,
            guide.anchors.width == container.anchors.width * 2,
            guide.anchors.center == container.anchors.center
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }
    
    func testAddingMultiplePriorityExpressionsToView() {
        _ = container.addLayoutExpressions(
            guide.anchors.top == container.anchors.top + 10 <<~ .defaultLow,
            guide.anchors.width == container.anchors.width * 2 <<~ .required,
            guide.anchors.center == container.anchors.center <<~ .defaultHigh
        )
        XCTAssert(container.constraints.count == 4, "Expected exactly 4 constraints")
    }
}
