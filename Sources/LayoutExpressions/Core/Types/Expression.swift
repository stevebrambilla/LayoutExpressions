//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

#if os(macOS) && !targetEnvironment(macCatalyst)
import AppKit
#else
import UIKit
#endif

public protocol ExpressionProtocol {
	func update(priority: Priority) -> Self
	func evaluateAll() -> [Constraint]
}

public protocol DistinctExpressionProtocol: ExpressionProtocol {
	func evaluateDistinct() -> Constraint
}
