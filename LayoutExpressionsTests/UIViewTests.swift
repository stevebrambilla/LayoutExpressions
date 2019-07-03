//
//  UIViewTests.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2019-07-02.
//  Copyright © 2019 Steve Brambilla. All rights reserved.
//

import LayoutExpressions
import XCTest

class UIViewTests: XCTestCase {

    var container = UIView()
    var subview = UIView()

    override func setUp() {
        super.setUp()

        container = UIView()
        subview = UIView()

        container.addSubview(subview)
    }

    func testLayoutMarginsLayoutArea() {
        let top = evaluateLayoutExpression(subview.anchors.top == container.anchors.margins.top)
        XCTAssert(top.firstItem === subview)
        XCTAssert(top.secondItem === container.layoutMarginsGuide)
        XCTAssert(top.firstAttribute == .top)
        XCTAssert(top.secondAttribute == .top)

        let left = evaluateLayoutExpression(subview.anchors.left == container.anchors.margins.left)
        XCTAssert(left.firstItem === subview)
        XCTAssert(left.secondItem === container.layoutMarginsGuide)
        XCTAssert(left.firstAttribute == .left)
        XCTAssert(left.secondAttribute == .left)

        let bottom = evaluateLayoutExpression(subview.anchors.bottom == container.anchors.margins.bottom)
        XCTAssert(bottom.firstItem === subview)
        XCTAssert(bottom.secondItem === container.layoutMarginsGuide)
        XCTAssert(bottom.firstAttribute == .bottom)
        XCTAssert(bottom.secondAttribute == .bottom)

        let right = evaluateLayoutExpression(subview.anchors.right == container.anchors.margins.right)
        XCTAssert(right.firstItem === subview)
        XCTAssert(right.secondItem === container.layoutMarginsGuide)
        XCTAssert(right.firstAttribute == .right)
        XCTAssert(right.secondAttribute == .right)
    }

    func testReadableContentLayoutArea() {
        let top = evaluateLayoutExpression(subview.anchors.top == container.anchors.readable.top)
        XCTAssert(top.firstItem === subview)
        XCTAssert(top.secondItem === container.readableContentGuide)
        XCTAssert(top.firstAttribute == .top)
        XCTAssert(top.secondAttribute == .top)

        let left = evaluateLayoutExpression(subview.anchors.left == container.anchors.readable.left)
        XCTAssert(left.firstItem === subview)
        XCTAssert(left.secondItem === container.readableContentGuide)
        XCTAssert(left.firstAttribute == .left)
        XCTAssert(left.secondAttribute == .left)

        let bottom = evaluateLayoutExpression(subview.anchors.bottom == container.anchors.readable.bottom)
        XCTAssert(bottom.firstItem === subview)
        XCTAssert(bottom.secondItem === container.readableContentGuide)
        XCTAssert(bottom.firstAttribute == .bottom)
        XCTAssert(bottom.secondAttribute == .bottom)

        let right = evaluateLayoutExpression(subview.anchors.right == container.anchors.readable.right)
        XCTAssert(right.firstItem === subview)
        XCTAssert(right.secondItem === container.readableContentGuide)
        XCTAssert(right.firstAttribute == .right)
        XCTAssert(right.secondAttribute == .right)
    }
}
