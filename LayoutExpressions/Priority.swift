//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// MARK: - Priority

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

public func <~ <L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>, priority: SystemPriority) -> Expression<L, R> {
	return expression.updatePriority(priority.toRaw())
}

public func <~ <L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>, priority: Priority) -> Expression<L, R> {
	return expression.updatePriority(priority)
}