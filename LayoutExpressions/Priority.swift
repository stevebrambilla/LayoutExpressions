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

public func <~ <Left: LeftArgument, Right: RightArgument>(expression: Expression<Left, Right>, priority: SystemPriority) -> Expression<Left, Right> {
	return expression.updatePriority(priority.rawValue)
}

public func <~ <Left: LeftArgument, Right: RightArgument>(expression: Expression<Left, Right>, priority: Priority) -> Expression<Left, Right> {
	return expression.updatePriority(priority)
}
