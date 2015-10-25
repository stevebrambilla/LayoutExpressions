//  Copyright (c) 2014 Steve Brambilla. All rights reserved.

import UIKit

// ----------------------------------------------------------------------------
// MARK: - UIViewController

extension UIViewController {
	/// The layout expression argument for the .Bottom attribute of the view controller's topLayoutGuide.
	public var lexTopLayoutGuide: AttributeArgument {
		return self.topLayoutGuide.lexBottom
	}

	/// The layout expression argument for the .Top attribute of the view controller's topLayoutGuide.
	public var lexBottomLayoutGuide: AttributeArgument {
		return self.bottomLayoutGuide.lexTop
	}
}

// ----------------------------------------------------------------------------
// MARK: - UILayoutSupport

extension UILayoutSupport {
	/// The distinct .Top layout expression argument.
	public var lexTop: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Top)
	}

	/// The distinct .Bottom layout expression argument.
	public var lexBottom: AttributeArgument {
		return AttributeArgument(item: self, attribute: .Bottom)
	}
}
