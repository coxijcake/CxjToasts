//
//  CxjToastConfiguration+ToastCoexistencePolicy.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 14/12/2024.
//

import Foundation

extension CxjToastConfiguration {
    /// Defines the policy for handling the coexistence of toasts when a new toast
    /// matching the specified `comparisonCriteria` is shown.
    ///
    /// This structure determines how the current toast should behave when another toast,
    /// matching the criteria defined in `CxjToastComparisonCriteria`, is displayed.
    /// The behavior is specified by the `behaviour` property.
	public struct ToastCoexistencePolicy: Sendable {
        /// The behavior to execute for the current toast when a new toast
        /// matching the specified `comparisonCriteria` is shown.
		let behaviour: Behavior
        
        /// Criteria to determine which toasts are considered overlapping.
		let comparisonCriteria: CxjToastComparisonCriteria
		
		public init(
			handling: Behavior,
			comparisonCriteria: CxjToastComparisonCriteria
		) {
			self.behaviour = handling
			self.comparisonCriteria = comparisonCriteria
		}
	}
}

//MARK: - ToastCoexistencePolicy + Behavior
extension CxjToastConfiguration.ToastCoexistencePolicy {
    /// Defines the behavior for handling toast overlap and visibility conflicts.
    ///
    /// This enumeration specifies what should happen to the current toast when other
    /// toasts matching the specified `comparisonCriteria` appear. The behavior can include
    /// stacking, hiding, or dismissing the toast.
    public enum Behavior: Sendable {
        public struct StackAttributes: Sendable {
            /// Maximum number of toasts that can be visible simultaneously.
            let maxVisibleToasts: Int
            
            /// Whether the timers for stacked but non-visible toasts should stop running.
            let shouldStopTimerForStackedUnvisibleToasts: Bool
            
            public init(
                maxVisibleToasts: Int,
                shouldStopTimerForStackedUnvisibleToasts: Bool
            ) {
                self.maxVisibleToasts = maxVisibleToasts
                self.shouldStopTimerForStackedUnvisibleToasts = shouldStopTimerForStackedUnvisibleToasts
            }
        }
        
        public struct HideAttributes: Sendable {
            /// Whether the timers for hidden toasts should stop running.
            let shouldStopTimerForHiddenToasts: Bool
            
            public init(shouldStopTimerForHiddenToasts: Bool) {
                self.shouldStopTimerForHiddenToasts = shouldStopTimerForHiddenToasts
            }
        }
        
        /// Stack the current toast visually with other matching toasts.
        case stack(attributes: StackAttributes)
        
        /// Keep only the most recent toast visible, hiding other matching toasts.
        case hide(attributes: HideAttributes)
        
        /// Dismiss the current toast when a new toast matching the comparison criteria appears.
        case dismiss
    }
}
