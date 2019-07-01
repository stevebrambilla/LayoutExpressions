//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public protocol InsetsProtocol {
	var value: Insets? { get }
}

public struct NoInsets: InsetsProtocol {
	public let value: Insets? = nil
	internal init() {}
}

public struct UndefinedInsets: InsetsProtocol {
	public let value: Insets? = nil
	internal init() {}
}

public struct ValueInsets: InsetsProtocol {
	public let value: Insets?
	internal init(value: Insets) {
		self.value = value
	}
}

public struct Insets {
	public let top: CGFloat
	public let left: CGFloat
	public let bottom: CGFloat
	public let right: CGFloat

	public init(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
		self.top = top
		self.left = left
		self.bottom = bottom
		self.right = right
	}

	public init(_ insets: UIEdgeInsets) {
		self.init(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
	}

	public static var zeroInsets: Insets {
		Insets(top: 0, left: 0, bottom: 0, right: 0)
	}
}
