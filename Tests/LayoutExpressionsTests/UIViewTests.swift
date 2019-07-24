//  Copyright © 2019 Steve Brambilla. All rights reserved.

#if canImport(UIKit)

import LayoutExpressions
import UIKit
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
        let top = Constraint.evaluate(subview.anchors.top == container.anchors.margins.top)
        assertConstraint(top, first: subview, .top, relation: .equal, second: container.layoutMarginsGuide, .top)

        let left = Constraint.evaluate(subview.anchors.left == container.anchors.margins.left)
        assertConstraint(left, first: subview, .left, relation: .equal, second: container.layoutMarginsGuide, .left)

        let bottom = Constraint.evaluate(subview.anchors.bottom == container.anchors.margins.bottom)
        assertConstraint(bottom, first: subview, .bottom, relation: .equal, second: container.layoutMarginsGuide, .bottom)

        let right = Constraint.evaluate(subview.anchors.right == container.anchors.margins.right)
        assertConstraint(right, first: subview, .right, relation: .equal, second: container.layoutMarginsGuide, .right)
    }

    func testReadableContentLayoutArea() {
        let top = Constraint.evaluate(subview.anchors.top == container.anchors.readable.top)
        assertConstraint(top, first: subview, .top, relation: .equal, second: container.readableContentGuide, .top)

        let left = Constraint.evaluate(subview.anchors.left == container.anchors.readable.left)
        assertConstraint(left, first: subview, .left, relation: .equal, second: container.readableContentGuide, .left)

        let bottom = Constraint.evaluate(subview.anchors.bottom == container.anchors.readable.bottom)
        assertConstraint(bottom, first: subview, .bottom, relation: .equal, second: container.readableContentGuide, .bottom)

        let right = Constraint.evaluate(subview.anchors.right == container.anchors.readable.right)
        assertConstraint(right, first: subview, .right, relation: .equal, second: container.readableContentGuide, .right)
    }
    
    func testSafeAreaLayoutArea() {
        guard #available(iOS 11.0, tvOS 11.0, *) else { return }
    
        let top = Constraint.evaluate(subview.anchors.top == container.anchors.safeArea.top)
        assertConstraint(top, first: subview, .top, relation: .equal, second: container.safeAreaLayoutGuide, .top)
        
        let left = Constraint.evaluate(subview.anchors.left == container.anchors.safeArea.left)
        assertConstraint(left, first: subview, .left, relation: .equal, second: container.safeAreaLayoutGuide, .left)
        
        let bottom = Constraint.evaluate(subview.anchors.bottom == container.anchors.safeArea.bottom)
        assertConstraint(bottom, first: subview, .bottom, relation: .equal, second: container.safeAreaLayoutGuide, .bottom)
        
        let right = Constraint.evaluate(subview.anchors.right == container.anchors.safeArea.right)
        assertConstraint(right, first: subview, .right, relation: .equal, second: container.safeAreaLayoutGuide, .right)
    }
}

#endif

