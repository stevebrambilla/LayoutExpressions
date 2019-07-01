//
//  AnchorsExtensionsProvider.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2017-06-07.
//  Copyright © 2017 Steve Brambilla. All rights reserved.
//

import Foundation

/// Describes a provider of lauout anchors.
///
/// Custom types that support layout anchors can adopt this protocol to vend 
/// custom layout anchors.
public protocol AnchorsExtensionsProvider: class {}

extension AnchorsExtensionsProvider {
	/// A proxy which hosts layout anchors for `self`.
	public var anchors: Anchors<Self> {
		Anchors(self)
	}
}

/// A proxy which hosts layout anchor extensions for `Base`.
public struct Anchors<Base> {
	public let base: Base

	fileprivate init(_ base: Base) {
		self.base = base
	}
}
