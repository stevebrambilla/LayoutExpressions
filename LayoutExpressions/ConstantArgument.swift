//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

class ConstantArgument: DistinctRightHandSideArgument {
	let _constant: Float

	init(constant: Float) {
		_constant = constant
	}

	// RightHandSideArgument
	func attributeValues(leftAttribute: NSLayoutAttribute) -> (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return self.attributeValues
	}

	// DistinctRightHandSideArgument
	var attributeValues: (item: AnyObject?, attribute: NSLayoutAttribute, multiplier: CGFloat?, constant: CGFloat?) {
		return (item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: _constant)
	}
}