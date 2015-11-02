//
//  UILayoutGuide+LayoutExpressions.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2015-11-01.
//  Copyright © 2015 Steve Brambilla. All rights reserved.
//

import UIKit

extension UILayoutGuide {
	/// The distinct .Leading layout expression argument.
	public var lexLeading: XAxisAnchor<UndefinedConstant> {
		return XAxisAnchor(anchor: leadingAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Trailing layout expression argument.
	public var lexTrailing: XAxisAnchor<UndefinedConstant> {
		return XAxisAnchor(anchor: trailingAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Top layout expression argument.
	public var lexTop: YAxisAnchor<UndefinedConstant> {
		return YAxisAnchor(anchor: topAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Left layout expression argument.
	public var lexLeft: XAxisAnchor<UndefinedConstant> {
		return XAxisAnchor(anchor: leftAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Bottom layout expression argument.
	public var lexBottom: YAxisAnchor<UndefinedConstant> {
		return YAxisAnchor(anchor: bottomAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Right layout expression argument.
	public var lexRight: XAxisAnchor<UndefinedConstant> {
		return XAxisAnchor(anchor: rightAnchor, constant: UndefinedConstant())
	}

	/// The distinct .CenterX layout expression argument.
	public var lexCenterX: XAxisAnchor<UndefinedConstant> {
		return XAxisAnchor(anchor: centerXAnchor, constant: UndefinedConstant())
	}

	/// The distinct .CenterY layout expression argument.
	public var lexCenterY: YAxisAnchor<UndefinedConstant> {
		return YAxisAnchor(anchor: centerYAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Width layout expression argument.
	public var lexWidth: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: widthAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}

	/// The distinct .Height layout expression argument.
	public var lexHeight: DimensionAnchor<UndefinedMultiplier, UndefinedConstant> {
		return DimensionAnchor(dimension: heightAnchor, multiplier: UndefinedMultiplier(), constant: UndefinedConstant())
	}
}

extension UILayoutGuide {
	/// The composite "edges" layout expression argument.
	/// Evaluates to .Top, .Left, .Bottom, .Right constraints.
	public var lexEdges: EdgesAnchor<UndefinedInsets> {
		return EdgesAnchor(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor, insets: UndefinedInsets())
	}
}


extension UILayoutGuide {
	/// The composite "center" layout expression argument.
	/// Evaluates to .CenterX, .CenterY constraints.
	public var lexCenter: CenterAnchor<UndefinedOffset> {
		return CenterAnchor(centerXAnchor: centerXAnchor, centerYAnchor: centerYAnchor, offset: UndefinedOffset())
	}
}

extension UILayoutGuide {
	/// The composite "size" layout expression argument.
	/// Evaluates to .Width, .Height constraints.
	public var lexSize: SizeAnchor<UndefinedSize> {
		return SizeAnchor(widthAnchor: widthAnchor, heightAnchor: heightAnchor, size: UndefinedSize())
	}
}
