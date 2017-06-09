//  Copyright © 2017 Steve Brambilla. All rights reserved.

import UIKit

extension Anchors where Base: UIScrollView {
	/// A layout area representing the view's `contentLayoutGuide`.
	@available(iOS 11.0, tvOS 11.0, *)
	public var content: LayoutAreaAnchors {
		return LayoutAreaAnchors(guide: base.contentLayoutGuide)
	}

	/// A layout area representing the view's `frameLayoutGuide`.
	@available(iOS 11.0, tvOS 11.0, *)
	public var frame: LayoutAreaAnchors {
		return LayoutAreaAnchors(guide: base.frameLayoutGuide)
	}
}
