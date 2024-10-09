//
//  CxjToastConfiguration+Layout.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation

extension CxjToastConfiguration {
	public struct Layout {
		public enum Placement {
			case top(safeArea: Bool, verticalOffset: CGFloat)
			case center
			case bottom(safeArea: Bool, verticalOffset: CGFloat)
		}
		
		let constraints: Constraints
		let placement: Placement
		
		public init(
			constraints: Constraints,
			placement: Placement
		) {
			self.constraints = constraints
			self.placement = placement
		}
	}
}
