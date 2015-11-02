//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public typealias Priority = Float

public enum SystemPriority: Priority {
	case Required = 1000
	case DefaultHigh = 750
	case DefaultLow = 250
	case FittingSizeLevel = 50
}

infix operator  <~ {
	associativity left
	precedence 125 // Less than the Comparative operators (130)
}

public func <~ <Expression: ExpressionType>(expression: Expression, priority: SystemPriority) -> Expression {
	return expression.updatePriority(priority.rawValue)
}
