//  Copyright © 2017 Steve Brambilla. All rights reserved.

import Foundation

extension UIViewController: AnchorsExtensionsProvider {}

extension Anchors where Base: UIViewController {
	/// A layout expression anchor representing the bottom edge of the view
	/// controller's top layout guide.
	public var top: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.topLayoutGuide.bottomAnchor), constant: UndefinedConstant())
	}

	/// A layout expression anchor representing the top edge of the view 
	/// controller's bottom layout guide.
	public var bottom: AxisAnchor<YAxis, UndefinedConstant> {
		return AxisAnchor(axis: YAxis(anchor: base.bottomLayoutGuide.topAnchor), constant: UndefinedConstant())
	}
}
