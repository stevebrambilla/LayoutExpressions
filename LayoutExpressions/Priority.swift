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

// TODO: change these to "func <~ <T: Expression>(expression: T, priority: <type>) -> T" once Generics support is good to go

@infix func <~(expression: Expression, priority: SystemPriority) -> Expression {
	return expression.updatePriority(priority.toRaw())
}

@infix func <~(expression: Expression, priority: Priority) -> Expression {
	return expression.updatePriority(priority)
}