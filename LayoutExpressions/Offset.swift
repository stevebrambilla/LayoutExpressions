//
//  Offset.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

public protocol OffsetType {
	var value: Offset? { get }
}

public struct NoOffset: OffsetType {
	public let value: Offset? = nil
	internal init() {}
}

public struct UndefinedOffset: OffsetType {
	public let value: Offset? = nil
	internal init() {}
}

public struct ValueOffset: OffsetType {
	public let value: Offset?
	internal init(value: Offset) {
		self.value = value
	}
}

public struct Offset {
	public var horizontal: CGFloat
	public var vertical: CGFloat

	public init(horizontal: CGFloat, vertical: CGFloat) {
		self.horizontal = horizontal
		self.vertical = vertical
	}

	public init(_ offset: UIOffset) {
		self.init(horizontal: offset.horizontal, vertical: offset.vertical)
	}

	public init(_ point: CGPoint) {
		self.init(horizontal: point.x, vertical: point.y)
	}

	public static var zeroOffset: Offset {
		return Offset(horizontal: 0, vertical: 0)
	}
}