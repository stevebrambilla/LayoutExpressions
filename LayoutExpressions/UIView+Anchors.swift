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

extension Anchors where Base: UIView {
    /// A composite layout expression anchor representing all four edges of the view's margins.
    public var allMargins: EdgesAnchor<UndefinedInsets> {
        return margins.edges
    }
 
    /// A composite layout expression anchor representing the horizontal edges (leading and trailing) of the view's layout margin.
    public var horizontalMargins: SingleAxisEdgesAnchor<XAxisEdges, UndefinedConstant> {
        return margins.horizontalEdges
    }
    
    /// A composite layout expression anchor representing the vertical edges (top and bottom) of the view's layout margin.
    public var verticalMargins: SingleAxisEdgesAnchor<YAxisEdges, UndefinedConstant> {
        return margins.verticalEdges
    }
}
