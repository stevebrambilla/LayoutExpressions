//  Copyright © 2017 Steve Brambilla. All rights reserved.

import AVKit

extension Anchors where Base: AVPlayerViewController {
	/// A layout area representing the view's `unobscuredContentGuide`.
	@available(tvOS 11.0, *)
	public var unobscured: LayoutAreaAnchors {
		LayoutAreaAnchors(guide: base.unobscuredContentGuide)
	}
}
