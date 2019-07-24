//  Copyright © 2019 Steve Brambilla. All rights reserved.

#if canImport(UIKit)

import UIKit
public typealias View = UIKit.UIView
public typealias LayoutGuide = UIKit.UILayoutGuide
public typealias Constraint = UIKit.NSLayoutConstraint

#elseif canImport(AppKit)

import AppKit
public typealias View = AppKit.NSView
public typealias LayoutGuide = AppKit.NSLayoutGuide
public typealias Constraint = AppKit.NSLayoutConstraint

#else
#error("Requires either UIKit or AppKit")
#endif
