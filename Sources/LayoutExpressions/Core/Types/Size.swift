//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import CoreGraphics

public protocol SizeProtocol {
	var value: Size? { get }
}

public struct NoSize: SizeProtocol {
	public let value: Size? = nil
	internal init() {}
}

public struct UndefinedSize: SizeProtocol {
	public let value: Size? = nil
	internal init() {}
}

public struct ValueSize: SizeProtocol {
	public let value: Size?
	internal init(value: Size) {
		self.value = value
	}
}

public struct Size {
	let width: CGFloat
	let height: CGFloat

	public init(width: CGFloat, height: CGFloat) {
		self.width = width
		self.height = height
	}

	public init(_ size: CGSize) {
		self.width = size.width
		self.height = size.height
	}

	public static var zeroSize: Size {
		Size(width: 0, height: 0)
	}
}
