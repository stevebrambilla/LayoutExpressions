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
		self >= 0 && self <= 1000
	}

    internal var layoutPriority: UILayoutPriority {
        UILayoutPriority(rawValue: self)
    }
}

precedencegroup PrioritizationPrecedence {
	lowerThan: ComparisonPrecedence
}

infix operator <<~ : PrioritizationPrecedence

public func <<~ <Expression: ExpressionProtocol>(expression: Expression, priority: Float) -> Expression {
	expression.update(priority: priority)
}

public func <<~ <Expression: ExpressionProtocol>(expression: Expression, priority: Int) -> Expression {
	expression.update(priority: Priority(priority))
}

public func <<~ <Expression: ExpressionProtocol>(expression: Expression, priority: SystemPriority) -> Expression {
	expression.update(priority: priority.rawValue)
}
