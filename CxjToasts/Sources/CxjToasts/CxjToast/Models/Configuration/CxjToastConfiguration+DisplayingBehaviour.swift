//
//  CxjToastConfiguration+DisplayingBehaviour.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

extension CxjToastConfiguration {
	public struct DisplayingBehaviour: Sendable {
		public enum Action: Sendable {
			public struct StackAttributes: Sendable {
				let maxVisibleToasts: Int
				let shouldStopTimerForStackedUnvisibleToasts: Bool
				
				public init(maxVisibleToasts: Int, shouldStopTimerForStackedUnvisibleToasts: Bool) {
					self.maxVisibleToasts = maxVisibleToasts
					self.shouldStopTimerForStackedUnvisibleToasts = shouldStopTimerForStackedUnvisibleToasts
				}
			}
			
			public struct HideAttributes: Sendable {
				let shouldStopTimerForHiddenToasts: Bool
				
				public init(shouldStopTimerForHiddenToasts: Bool) {
					self.shouldStopTimerForHiddenToasts = shouldStopTimerForHiddenToasts
				}
			}
			
			case stack(attributes: StackAttributes)
			case hide(attributes: HideAttributes)
			case dismiss
		}
		
		
		let action: Action
		let comparisonCriteria: CxjToastComparisonCriteria
		
		public init(
			handling: Action,
			comparisonCriteria: CxjToastComparisonCriteria
		) {
			self.action = handling
			self.comparisonCriteria = comparisonCriteria
		}
	}
}
