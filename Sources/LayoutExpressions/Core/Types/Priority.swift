//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

public struct Priority: RawRepresentable, Comparable, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral {
    public let rawValue: Float
    
    public init(rawValue: Float) {
        self.rawValue = rawValue
    }
    
    public init(integerLiteral value: Int) {
        self.rawValue = Float(value)
    }
    
    public init(floatLiteral value: Float) {
        self.rawValue = value
    }
    
    public static func < (lhs: Priority, rhs: Priority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    internal var isValid: Bool {
        self >= 0 && self <= 1000
    }
}

// MARK: - System Priorities

#if canImport(UIKit)

/// UIKit
public extension Priority {
    internal init(priority: UILayoutPriority) {
        self.rawValue = priority.rawValue
    }
    
    internal var layoutPriority: UILayoutPriority {
        UILayoutPriority(rawValue: self.rawValue)
    }
    
    /// A required constraint.
    static let required = Priority(priority: .required)
    
    /// The priority level with which a button resists compressing its content.
    static let defaultHigh = Priority(priority: .defaultHigh)
    
    /// The priority level at which a button hugs its contents horizontally.
    static let defaultLow = Priority(priority: .defaultLow)
    
    /// The priority level with which the view wants to conform to the target size in that
    /// computation.
    static let fittingSizeLevel = Priority(priority: .fittingSizeLevel)
}
    
#elseif canImport(AppKit)
    
/// AppKit
public extension Priority {
    internal init(priority: NSLayoutConstraint.Priority) {
        self.rawValue = priority.rawValue
    }
    
    internal var layoutPriority: NSLayoutConstraint.Priority {
        NSLayoutConstraint.Priority(rawValue: self.rawValue)
    }
    
    /// A required constraint.
    static let required = Priority(priority: .required)

    /// Priority level with which a button resists compressing its content.
    static let defaultHigh = Priority(priority: .defaultHigh)

    /// Appropriate priority level for a drag that may end up resizing the window.
    static let dragThatCanResizeWindow = Priority(priority: .dragThatCanResizeWindow)

    /// Priority level for the window’s current size.
    static let windowSizeStayPut = Priority(priority: .windowSizeStayPut)

    /// Priority level at which a split view divider, say, is dragged.
    static let dragThatCannotResizeWindow = Priority(priority: .dragThatCannotResizeWindow)

    /// Priority level at which a button hugs its contents horizontally.
    static let defaultLow = Priority(priority: .defaultLow)
    
    /// When you send a `fittingSize` message to a view, the smallest size that is large enough for
    /// the view's contents is computed.
    static let fittingSizeCompression = Priority(priority: .fittingSizeCompression)
}

#endif

public extension Priority {
    /// Priority that keeps the view from being stretched or compressed but still provides an
    /// emergency pressure valve, just in case your view is displayed in an environment that is
    /// bigger or smaller than you expected.
    static let veryHigh: Priority = 999
}

// MARK: - Arithmetic Operators

public func + (lhs: Priority, rhs: Priority) -> Priority {
    Priority(rawValue: lhs.rawValue + rhs.rawValue)
}

public func - (lhs: Priority, rhs: Priority) -> Priority {
    Priority(rawValue: lhs.rawValue - rhs.rawValue)
}

// MARK: - Prioritize Expression Operator

precedencegroup PrioritizationPrecedence {
    lowerThan: ComparisonPrecedence
}

infix operator <<~ : PrioritizationPrecedence

public func <<~ <Expression: ExpressionProtocol>(expression: Expression, priority: Priority) -> Expression {
    expression.update(priority: priority)
}
