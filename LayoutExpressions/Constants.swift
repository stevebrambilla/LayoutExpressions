//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public protocol ConstantType {
	var value: CGFloat? { get }
}

public struct NoConstant: ConstantType {
	public let value: CGFloat? = nil
	internal init() {}
}

public struct UndefinedConstant: ConstantType {
	public let value: CGFloat? = nil
	internal init() {}
}

public struct ValueConstant: ConstantType {
	public let value: CGFloat?
	internal init(value: CGFloat) {
		self.value = value
	}
}
