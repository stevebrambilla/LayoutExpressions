//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import CoreGraphics

public protocol MultiplierProtocol {
    var value: CGFloat? { get }
}

public struct NoMultiplier: MultiplierProtocol {
    public let value: CGFloat? = nil
    internal init() {}
}

public struct UndefinedMultiplier: MultiplierProtocol {
    public let value: CGFloat? = nil
    internal init() {}
}

public struct ValueMultiplier: MultiplierProtocol {
    public let value: CGFloat?
    internal init(value: CGFloat) {
        self.value = value
    }
}
