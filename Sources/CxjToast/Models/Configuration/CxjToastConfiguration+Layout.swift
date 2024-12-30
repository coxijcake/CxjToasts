//
//  CxjToastConfiguration+Layout.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation

extension CxjToastConfiguration {
	public struct Layout: Sendable {
		public enum Placement: Sendable {
			public struct VerticalSidePositionParams: Equatable, Sendable {
				let offset: CGFloat
				let includingSafeArea: Bool
				
				public init(
					offset: CGFloat,
					includingSafeArea: Bool
				) {
					self.offset = offset
					self.includingSafeArea = includingSafeArea
				}
			}
			
			case top(params: VerticalSidePositionParams)
			case center
			case bottom(params: VerticalSidePositionParams)
		}
		
		public let constraints: Constraints
		public let placement: Placement
		
		public init(
			constraints: Constraints,
			placement: Placement
		) {
			self.constraints = constraints
			self.placement = placement
		}
	}
}
