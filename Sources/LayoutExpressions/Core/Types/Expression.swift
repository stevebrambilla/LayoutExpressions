//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

public protocol ExpressionProtocol {
    func update(priority: Priority) -> Self
    func evaluateAll() -> [Constraint]
}

public protocol DistinctExpressionProtocol: ExpressionProtocol {
    func evaluateDistinct() -> Constraint
}
