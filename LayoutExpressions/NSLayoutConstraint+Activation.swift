//
//  NSLayoutConstraint+Activation.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-12.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif

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

	/// Activates or deactivates each constraint in the array depending on the 
	/// value of `active`.
	///
	/// This convenience method provides an easy way to activate or deactivate a
	/// set of constraints with one call. The effect of this method is the same
	/// as setting the active property of each constraint to `false`. Typically,
	/// using this method is more efficient than activating or deactivating each
	/// constraint individually.
	public func setConstraints(active: Bool) {
		if active {
			NSLayoutConstraint.activate(self)
		} else {
			NSLayoutConstraint.deactivate(self)
		}
	}
}
