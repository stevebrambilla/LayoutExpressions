//  Copyright (c) 2015 Steve Brambilla. All rights reserved.

extension LayoutGuide: AnchorsExtensionsProvider {}

extension Anchors where Base: LayoutGuide {
	/// A layout expression anchor representing the leading edge of the layout guide's frame.
	public var leading: AxisAnchor<XAxis, UndefinedConstant> {
		AxisAnchor(axis: XAxis(anchor: base.leadingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the trailing edge of the layout guide's frame.
	public var trailing: AxisAnchor<XAxis, UndefinedConstant> {
		AxisAnchor(axis: XAxis(anchor: base.trailingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the top edge of the layout guide's frame.
	public var top: AxisAnchor<YAxis, UndefinedConstant> {
		AxisAnchor(axis: YAxis(anchor: base.topAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the left edge of the layout guide's frame.
	public var left: AxisAnchor<XAxis, UndefinedConstant> {
		AxisAnchor(axis: XAxis(anchor: base.leftAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the bottom edge of the layout guide's frame.
	public var bottom: AxisAnchor<YAxis, UndefinedConstant> {
		AxisAnchor(axis: YAxis(anchor: base.bottomAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the right edge of the layout guide's frame.
	public var right: AxisAnchor<XAxis, UndefinedConstant> {
		AxisAnchor(axis: XAxis(anchor: base.rightAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the horizontal center of the layout guide's frame.
	public var centerX: AxisAnchor<XAxis, UndefinedConstant> {
		AxisAnchor(axis: XAxis(anchor: base.centerXAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the vertical center of the layout guide's frame.
	public var centerY: AxisAnchor<YAxis, UndefinedConstant> {
		AxisAnchor(axis: YAxis(anchor: base.centerYAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the width of the layout guide's frame.
	public var width: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		DimensionAnchor(dimension: base.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the height of the layout guide's frame.
	public var height: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		DimensionAnchor(dimension: base.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}
}

extension Anchors where Base: LayoutGuide {
	/// A composite layout expression anchor representing all four edges of the layout guide.
	public var edges: EdgesAnchor<UndefinedInsets> {
		EdgesAnchor(
            topAnchor: base.topAnchor,
            leftAnchor: base.leftAnchor,
            bottomAnchor: base.bottomAnchor,
            rightAnchor: base.rightAnchor,
            insets: UndefinedInsets()
        )
	}

	/// A composite layout expression anchor representing the center of the view.
	public var center: CenterAnchor<UndefinedOffset> {
		CenterAnchor(
            centerXAnchor: base.centerXAnchor,
		    centerYAnchor: base.centerYAnchor,
		    offset: UndefinedOffset()
        )
	}

	/// A composite layout expression anchor representing the size of the view.
	public var size: SizeAnchor<UndefinedSize> {
		SizeAnchor(
            widthAnchor: base.widthAnchor,
		    heightAnchor: base.heightAnchor,
		    size: UndefinedSize()
        )
	}
}
