//
//  CxjToastConfiguration+Constraints.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation

extension CxjToastConfiguration {
	public struct Constraints {
		public struct Values {
			let min: CGFloat
			let max: CGFloat
			
			public init(
				min: CGFloat,
				max: CGFloat
			) {
				self.min = min
				self.max = max
			}
		}
		
		public let width: Values
		public let height: Values
		
		public init(
			width: Values,
			height: Values
		) {
			self.width = width
			self.height = height
		}
	}
}
