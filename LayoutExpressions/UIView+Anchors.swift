//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

extension UIView: AnchorsExtensionsProvider {}

extension Anchors where Base: UIView {
	/// A layout expression anchor representing the leading edge of the view's frame.
	public var leading: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: base.leadingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the trailing edge of the view's frame.
	public var trailing: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: base.trailingAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the top edge of the view's frame.
	public var top: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.topAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the left edge of the view's frame.
	public var left: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: base.leftAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the bottom edge of the view's frame.
	public var bottom: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.bottomAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the right edge of the view's frame.
	public var right: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: base.rightAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the horizontal center of the view's frame.
	public var centerX: AxisAnchor<XAxis, UndefinedConstant> {
		return AxisAnchor(axis: XAxis(anchor: base.centerXAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the vertical center of the view's frame.
	public var centerY: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.centerYAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the width of the view's frame.
	public var width: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: base.widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the height of the view's frame.
	public var height: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: base.heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the baseline for the topmost line of text in the view.
	public var firstBaseline: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.firstBaselineAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the baseline for the bottommost line of text in the view.
	public var lastBaseline: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.lastBaselineAnchor), constant: UndefinedConstant())
	}
}

extension Anchors where Base: UIView {
	/// A composite layout expression anchor representing all four edges of the view.
	public var edges: EdgesAnchor<UndefinedInsets> {
		return EdgesAnchor(topAnchor: base.topAnchor, leftAnchor: base.leftAnchor, bottomAnchor: base.bottomAnchor, rightAnchor: base.rightAnchor, insets: UndefinedInsets())
	}

	/// A composite layout expression anchor representing the center of the view.
	public var center: CenterAnchor<UndefinedOffset> {
		return CenterAnchor(centerXAnchor: base.centerXAnchor, centerYAnchor: base.centerYAnchor, offset: UndefinedOffset())
	}

	/// A composite layout expression anchor representing the size of the view.
	public var size: SizeAnchor<UndefinedSize> {
		return SizeAnchor(widthAnchor: base.widthAnchor, heightAnchor: base.heightAnchor, size: UndefinedSize())
	}
}

extension Anchors where Base: UIView {
	/// A layout area representing the view's `layoutMarginsGuide`, representing
	/// the view's margins.
	public var margins: LayoutAreaAnchors {
		return LayoutAreaAnchors(guide: base.layoutMarginsGuide)
	}

	/// A layout area representing the view's `readableContentGuide`, a readable
	/// width within the view.
	public var readable: LayoutAreaAnchors {
		return LayoutAreaAnchors(guide: base.readableContentGuide)
	}
}
