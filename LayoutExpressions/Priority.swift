//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public typealias Priority = Float

public enum SystemPriority: Priority {
	case required = 1000
	case defaultHigh = 750
	case defaultLow = 250
	case fittingSizeLevel = 50
}

extension Priority {
	internal var isValid: Bool {
		return self >= 0 && self <= 1000
	}
}

precedencegroup PrioritizationPrecedence {
	lowerThan: ComparisonPrecedence
}

infix operator <<~ : PrioritizationPrecedence

public func <<~ <Expression: ExpressionType>(expression: Expression, priority: Float) -> Expression {
	return expression.updatePriority(priority)
}

public func <<~ <Expression: ExpressionType>(expression: Expression, priority: Int) -> Expression {
	return expression.updatePriority(Priority(priority))
}

public func <<~ <Expression: ExpressionType>(expression: Expression, priority: SystemPriority) -> Expression {
	return expression.updatePriority(priority.rawValue)
}
