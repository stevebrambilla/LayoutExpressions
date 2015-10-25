//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

public struct Parameters {
	let item: AnyObject?
	let attribute: NSLayoutAttribute
	let multiplier: CGFloat?
	let constant: CGFloat?
}

public protocol LeftArgument {
	var leftItem: AnyObject { get }
	var leftAttributes: [NSLayoutAttribute] { get }
}

public protocol RightArgument {
	func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters
}

public protocol DistinctLeftArgument: LeftArgument {
	var distinctLeftAttribute: NSLayoutAttribute { get }
}

public protocol DistinctRightArgument: RightArgument {
	var distinctRightParameters: Parameters { get }
}

// ----------------------------------------------------------------------------
// MARK: - Extensions

extension Parameters {
	internal static var noop: Parameters {
		return Parameters(item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: nil)
	}
}

extension DistinctLeftArgument {
	public var leftAttributes: [NSLayoutAttribute] {
		return [distinctLeftAttribute]
	}
}

extension DistinctRightArgument {
	public func rightParametersForAttribute(attribute: NSLayoutAttribute) -> Parameters {
		return distinctRightParameters
	}
}
