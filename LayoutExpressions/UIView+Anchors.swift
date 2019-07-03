//  Copyright © 2019 Steve Brambilla. All rights reserved.

import UIKit

extension Anchors where Base: UIView {
    /// A layout area representing the view's `layoutMarginsGuide`.
    public var margins: LayoutAreaAnchors {
        LayoutAreaAnchors(guide: base.layoutMarginsGuide)
    }

    /// A layout area representing the view's `readableContentGuide`.
    public var readable: LayoutAreaAnchors {
        LayoutAreaAnchors(guide: base.readableContentGuide)
    }

    /// A layout area representing the view's `safeAreaLayoutGuide`.
    @available(iOS 11.0, tvOS 11.0, *)
    public var safeArea: LayoutAreaAnchors {
        LayoutAreaAnchors(guide: base.safeAreaLayoutGuide)
    }
}
