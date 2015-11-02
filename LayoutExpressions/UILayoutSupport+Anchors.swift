//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - UILayoutSupport

extension UILayoutSupport {
	/// The distinct .Top layout expression argument.
	public var lexTop: YAxisAnchor<UndefinedConstant> {
		return YAxisAnchor(anchor: topAnchor, constant: UndefinedConstant())
	}

	/// The distinct .Bottom layout expression argument.
	public var lexBottom: YAxisAnchor<UndefinedConstant> {
		return YAxisAnchor(anchor: bottomAnchor, constant: UndefinedConstant())
	}
}

// ----------------------------------------------------------------------------
// MARK: - UIViewController

extension UIViewController {
	/// The layout expression argument for the .Bottom attribute of the view controller's topLayoutGuide.
	public var lexTopLayoutGuide: YAxisAnchor<UndefinedConstant> {
		return self.topLayoutGuide.lexBottom
	}

	/// The layout expression argument for the .Top attribute of the view controller's topLayoutGuide.
	public var lexBottomLayoutGuide: YAxisAnchor<UndefinedConstant> {
		return self.bottomLayoutGuide.lexTop
	}
}
