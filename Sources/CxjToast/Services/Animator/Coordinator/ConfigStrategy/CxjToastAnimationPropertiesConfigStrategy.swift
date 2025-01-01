//
//  CxjToastAnimationPropertiesConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation


@MainActor
protocol CxjToastAnimationPropertiesConfigStrategy {
	typealias Properties = CxjToastAnimator.ToastAnimatingProperties
	
	func dismissedStateAnimatingProperties() -> Properties
}
