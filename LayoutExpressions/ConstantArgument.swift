//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

public class ConstantArgument: DistinctRightArgument {
	private let constant: CGFloat

	internal init(constant: CGFloat) {
		self.constant = constant
	}

	// DistinctRightHandSideArgument
	public var distinctRightParameters: Parameters {
		return Parameters(item: nil, attribute: .NotAnAttribute, multiplier: nil, constant: constant)
	}
}
