//
//  AnchorsExtensionsProvider.swift
//  LayoutExpressions
//
//  Created by Steve Brambilla on 2017-06-07.
//  Copyright © 2017 Steve Brambilla. All rights reserved.
//

import Foundation

public protocol AnchorsExtensionsProvider: class {}

extension AnchorsExtensionsProvider {
	public var anchors: Anchors<Self> {
		return Anchors(self)
	}
}

public struct Anchors<Base> {
	public let base: Base

	fileprivate init(_ base: Base) {
		self.base = base
	}
}
