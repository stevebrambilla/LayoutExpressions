//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

import UIKit

extension UILayoutGuide {
	/// A layout expression anchor representing the leading edge of the layout guide's frame.
	public var lexLeading: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: leadingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the trailing edge of the layout guide's frame.
	public var lexTrailing: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: trailingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the top edge of the layout guide's frame.
	public var lexTop: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: topAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the left edge of the layout guide's frame.
	public var lexLeft: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: leftAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the bottom edge of the layout guide's frame.
	public var lexBottom: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: bottomAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the right edge of the layout guide's frame.
	public var lexRight: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: rightAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the horizontal center of the layout guide's frame.
	public var lexCenterX: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: centerXAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the vertical center of the layout guide's frame.
	public var lexCenterY: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: centerYAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the width of the layout guide's frame.
	public var lexWidth: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the height of the layout guide's frame.
	public var lexHeight: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}
}

extension UILayoutGuide {
	/// A composite layout expression anchor representing all four edges of the layout guide.
	public var lexEdges: EdgesAnchor<UndefinedInsets> {
		return EdgesAnchor(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: UndefinedInsets())
	}
}


extension UILayoutGuide {
	/// A composite layout expression anchor representing the center of the view.
	public var lexCenter: CenterAnchor<UndefinedOffset> {
		return CenterAnchor(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: UndefinedOffset())
	}
}

extension UILayoutGuide {
	/// A composite layout expression anchor representing the size of the view.
	public var lexSize: SizeAnchor<UndefinedSize> {
		return SizeAnchor(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: UndefinedSize())
	}
}
