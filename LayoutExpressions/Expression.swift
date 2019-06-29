//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public protocol ExpressionProtocol {
	func update(priority: Priority) -> Self
	func evaluateAll() -> [NSLayoutConstraint]
}

public protocol DistinctExpressionProtocol: ExpressionProtocol {
	func evaluateDistinct() -> NSLayoutConstraint
}
