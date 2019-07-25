//  Copyright © 2017 Steve Brambilla. All rights reserved.

#if canImport(UIKit)

import UIKit

extension UIViewController: AnchorsExtensionsProvider {}

extension Anchors where Base: UIViewController {
    /// A layout expression anchor representing the bottom edge of the view
    /// controller's top layout guide.
    @available(iOS, deprecated: 11.0)
    @available(tvOS, deprecated: 11.0)
    public var top: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.topLayoutGuide.bottomAnchor), constant: UndefinedConstant())
    }

    /// A layout expression anchor representing the top edge of the view
    /// controller's bottom layout guide.
    @available(iOS, deprecated: 11.0)
    @available(tvOS, deprecated: 11.0)
    public var bottom: AxisAnchor<YAxis, UndefinedConstant> {
        AxisAnchor(axis: YAxis(anchor: base.bottomLayoutGuide.topAnchor), constant: UndefinedConstant())
    }
}

#endif
