//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#else
#error("Requires either UIKit or AppKit")
#endif

public protocol OffsetProtocol {
	var value: Offset? { get }
}

public struct NoOffset: OffsetProtocol {
	public let value: Offset? = nil
	internal init() {}
}

public struct UndefinedOffset: OffsetProtocol {
	public let value: Offset? = nil
	internal init() {}
}

public struct ValueOffset: OffsetProtocol {
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

#if canImport(UIKit)
	public init(_ offset: UIOffset) {
		self.init(horizontal: offset.horizontal, vertical: offset.vertical)
	}
#endif

	public init(_ point: CGPoint) {
		self.init(horizontal: point.x, vertical: point.y)
	}

	public static var zeroOffset: Offset {
		Offset(horizontal: 0, vertical: 0)
	}
}
