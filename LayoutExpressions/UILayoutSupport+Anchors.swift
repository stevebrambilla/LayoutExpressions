//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - UILayoutSupport

extension UILayoutSupport {
	/// A layout expression anchor representing the top edge of the layout support's frame.
	public var lexTop: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: topAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the bottom edge of the layout support's frame.
	public var lexBottom: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: bottomAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the height of the layout support's frame.
	public var lexHeight: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - UIViewController

extension UIViewController {
	/// A layout expression anchor representing the bottom edge of the view controller's top layout guide.
	public var lexTopLayoutGuide: AxisAnchor<YAxis, UndefinedConstant> {
		return topLayoutGuide.lexBottom
	}

	/// A layout expression anchor representing the top edge of the view controller's bottom layout guide.
	public var lexBottomLayoutGuide: AxisAnchor<YAxis, UndefinedConstant> {
		return bottomLayoutGuide.lexTop
	}
}
