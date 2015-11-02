//
//  Size.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

public protocol SizeType {
	var value: Size? { get }
}

public struct NoSize: SizeType {
	public let value: Size? = nil
	internal init() {}
}

public struct UndefinedSize: SizeType {
	public let value: Size? = nil
	internal init() {}
}

public struct ValueSize: SizeType {
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

	public init(size: CGSize) {
		self.width = size.width
		self.height = size.height
	}

	public static var zeroSize: Size {
		return Size(width: 0, height: 0)
	}
}
