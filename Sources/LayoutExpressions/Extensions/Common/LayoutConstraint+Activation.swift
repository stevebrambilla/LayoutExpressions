//  Copyright © 2015 Steve Brambilla. All rights reserved.

extension Array where Element: Constraint {
	/// Activates each constraint in the array.
	///
	/// This convenience method provides an easy way to activate a set of 
	/// constraints with one call. The effect of this method is the same as 
	/// setting the active property of each constraint to `true`. Typically,
	/// using this method is more efficient than activating each constraint
	/// individually.
	public func activateConstraints() {
		Constraint.activate(self)
	}

	/// Deactivates each constraint in the array.
	///
	/// This convenience method provides an easy way to deactivate a set of
	/// constraints with one call. The effect of this method is the same as
	/// setting the active property of each constraint to `false`. Typically,
	/// using this method is more efficient than deactivating each constraint
	/// individually.
	public func deactivateConstraints() {
		Constraint.deactivate(self)
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
			Constraint.activate(self)
		} else {
			Constraint.deactivate(self)
		}
	}
}
