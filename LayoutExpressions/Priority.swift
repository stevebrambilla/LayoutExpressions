//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// MARK: Priority

typealias Priority = Float

enum SystemPriority: Priority {
	case Required = 1000
	case DefaultHigh = 750
	case DefaultLow = 250
	case FittingSizeLevel = 50
}

operator infix <~ {
	associativity left
	precedence 125 // Less than the Comparative operators (130)
}

@infix func <~ <L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>, priority: SystemPriority) -> Expression<L, R> {
	return expression.updatePriority(priority.toRaw())
}

@infix func <~ <L: LeftHandSideArgument, R: RightHandSideArgument>(expression: Expression<L, R>, priority: Priority) -> Expression<L, R> {
	return expression.updatePriority(priority)
}