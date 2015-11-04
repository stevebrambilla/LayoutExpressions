//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public protocol MultiplierType {
	var value: CGFloat? { get }
}

public struct NoMultiplier: MultiplierType {
	public let value: CGFloat? = nil
	internal init() {}
}

public struct UndefinedMultiplier: MultiplierType {
	public let value: CGFloat? = nil
	internal init() {}
}

public struct ValueMultiplier: MultiplierType {
	public let value: CGFloat?
	internal init(value: CGFloat) {
		self.value = value
	}
}
