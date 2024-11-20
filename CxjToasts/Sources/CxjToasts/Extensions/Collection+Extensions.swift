//
//  Collection+Extensions.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import Foundation

extension Collection {
	subscript (safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
	
	func withoutOptionals<Wrapped>() -> [Wrapped] where Element == Wrapped? {
		self.compactMap { $0 }
	}
}
