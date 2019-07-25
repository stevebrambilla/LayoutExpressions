//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import CoreGraphics

public protocol ConstantProtocol {
    var value: CGFloat? { get }
}

public struct NoConstant: ConstantProtocol {
    public let value: CGFloat? = nil
    internal init() {}
}

public struct UndefinedConstant: ConstantProtocol {
    public let value: CGFloat? = nil
    internal init() {}
}

public struct ValueConstant: ConstantProtocol {
    public let value: CGFloat?
    internal init(value: CGFloat) {
        self.value = value
    }
}
