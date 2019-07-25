//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

extension View: AnchorsExtensionsProvider {}

extension Anchors where Base: View {
    /// A layout expression anchor representing the leading edge of the view's frame.
    public var leading: AxisAnchor<XAxis, UndefinedConstant> {
        AxisAnchor(axis: XAxis(anchor: base.leadingAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the trailing edge of the view's frame.
    public var trailing: AxisAnchor<XAxis, UndefinedConstant> {
        AxisAnchor(axis: XAxis(anchor: base.trailingAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the top edge of the view's frame.
    public var top: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.topAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the left edge of the view's frame.
    public var left: AxisAnchor<XAxis, UndefinedConstant> {
        AxisAnchor(axis: XAxis(anchor: base.leftAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the bottom edge of the view's frame.
    public var bottom: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.bottomAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the right edge of the view's frame.
    public var right: AxisAnchor<XAxis, UndefinedConstant> {
        AxisAnchor(axis: XAxis(anchor: base.rightAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the horizontal center of the view's frame.
    public var centerX: AxisAnchor<XAxis, UndefinedConstant> {
        AxisAnchor(axis: XAxis(anchor: base.centerXAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the vertical center of the view's frame.
    public var centerY: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.centerYAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the width of the view's frame.
    public var width: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
        DimensionAnchor(dimension: base.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the height of the view's frame.
    public var height: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
        DimensionAnchor(dimension: base.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the baseline for the topmost line of text in the view.
    public var firstBaseline: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.firstBaselineAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the baseline for the bottommost line of text in the view.
    public var lastBaseline: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.lastBaselineAnchor), constant: UndefinedConstant())
    }
}

extension Anchors where Base: View {
    /// A composite layout expression anchor representing all four edges of the view.
    public var allEdges: BothAxisEdgesAnchor<UndefinedConstant> {
        BothAxisEdgesAnchor(
            top: base.topAnchor,
            bottom: base.bottomAnchor,
            leading: base.leadingAnchor,
            trailing: base.trailingAnchor,
            inset: UndefinedConstant()
        )
    }

    /// A composite layout expression anchor representing the horizontal edges (leading and trailing) of the view.
    public var horizontalEdges: SingleAxisEdgesAnchor<XAxisEdges, UndefinedConstant> {
        SingleAxisEdgesAnchor(
            axis: XAxisEdges(leading: base.leadingAnchor, trailing: base.trailingAnchor),
            inset: UndefinedConstant()
        )
    }

    /// A composite layout expression anchor representing the vertical edges (top and bottom) of the view.
    public var verticalEdges: SingleAxisEdgesAnchor<YAxisEdges, UndefinedConstant> {
        SingleAxisEdgesAnchor(
            axis: YAxisEdges(top: base.topAnchor, bottom: base.bottomAnchor),
            inset: UndefinedConstant()
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
