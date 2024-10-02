//
//  CxjToastAnimator+DefaultCenterConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	struct DefaultCenterConfigStrategy: DefaultConfigStrategy {
		let input: ConfigStrategyCommonInput
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			AnimatingProperties(
				alpha: .min,
				scale: CxjToastAnimator.AnimatingProperties.Scale(x: 0.5, y: 0.5),
				translation: .initial,
				cornerRadius: input.presentedStateAnimatingProperties.cornerRadius,
				shadowOverlay: .off
			)
		}
	}
}
