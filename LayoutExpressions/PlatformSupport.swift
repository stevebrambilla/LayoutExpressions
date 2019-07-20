//  Copyright © 2019 Steve Brambilla. All rights reserved.

#if os(macOS) && !targetEnvironment(macCatalyst)

import AppKit

public typealias View = AppKit.NSView
public typealias LayoutGuide = AppKit.NSLayoutGuide
public typealias Constraint = AppKit.NSLayoutConstraint

#else

import UIKit

public typealias View = UIKit.UIView
public typealias LayoutGuide = UIKit.UILayoutGuide
public typealias Constraint = UIKit.NSLayoutConstraint

#endif
