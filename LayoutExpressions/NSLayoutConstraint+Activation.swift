//
//  NSLayoutConstraint+Activation.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-12.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

extension Array where Element: NSLayoutConstraint {
	/// Activates each constraint in the array.
	///
	/// This convenience method provides an easy way to activate a set of 
	/// constraints with one call. The effect of this method is the same as 
	/// setting the active property of each constraint to `true`. Typically,
	/// using this method is more efficient than activating each constraint
	/// individually.
	public func activateConstraints() {
		NSLayoutConstraint.activate(self)
	}

	/// Deactivates each constraint in the array.
	///
	/// This convenience method provides an easy way to deactivate a set of
	/// constraints with one call. The effect of this method is the same as
	/// setting the active property of each constraint to `false`. Typically,
	/// using this method is more efficient than deactivating each constraint
	/// individually.
	public func deactivateConstraints() {
		NSLayoutConstraint.deactivate(self)
	}
}
