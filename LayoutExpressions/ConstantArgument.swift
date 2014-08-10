//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// MARK: - Argument

public class ConstantArgument: DistinctRightHandSideArgument {
	private let constant: CGFloat

	init(constant: CGFloat) {
		self.constant = constant
	}

	// RightHandSideArgument
	public func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return self.attributeValues
	}

	// DistinctRightHandSideArgument
	public var attributeValues: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: constant)
	}
}