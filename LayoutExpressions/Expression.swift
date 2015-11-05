//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public protocol ExpressionType {
	func updatePriority(priority: Priority) -> Self
	func evaluateAll() -> [NSLayoutConstraint]
}

public protocol DistinctExpressionType: ExpressionType {
	func evaluateDistinct() -> NSLayoutConstraint
}
