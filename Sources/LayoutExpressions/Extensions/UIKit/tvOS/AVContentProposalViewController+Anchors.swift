//  Copyright © 2019 Steve Brambilla. All rights reserved.

#if os(tvOS)

import AVKit

@available(tvOS 10.0, *)
extension Anchors where Base: AVContentProposalViewController {
    /// A layout area representing the view controller's `playerLayoutGuide`.
    public var player: LayoutAreaAnchors {
        LayoutAreaAnchors(guide: base.playerLayoutGuide)
    }
}

#endif
