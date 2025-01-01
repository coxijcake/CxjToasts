//
//  CxjToastAnimator+DefaultCenterConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	struct DefaultCenterConfigStrategy: CxjToastAnimationPropertiesConfigStrategy {
		let input: ConfigStrategyCommonInput
		
		func dismissedStateAnimatingProperties() -> ToastAnimatingProperties {
			ToastAnimatingProperties(
				alpha: .min,
				scale: CxjToastAnimator.ToastAnimatingProperties.Scale(x: 0.5, y: 0.5),
				translation: .zero,
				cornerRadius: input.presentedStateAnimatingProperties.cornerRadius,
				shadowOverlay: .off
			)
		}
	}
}
