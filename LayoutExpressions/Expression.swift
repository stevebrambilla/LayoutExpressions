//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

#if os(macOS)
import AppKit
#else
import UIKit
#endif

public protocol ExpressionProtocol {
	func update(priority: Priority) -> Self
	func evaluateAll() -> [NSLayoutConstraint]
}

public protocol DistinctExpressionProtocol: ExpressionProtocol {
	func evaluateDistinct() -> NSLayoutConstraint
}
