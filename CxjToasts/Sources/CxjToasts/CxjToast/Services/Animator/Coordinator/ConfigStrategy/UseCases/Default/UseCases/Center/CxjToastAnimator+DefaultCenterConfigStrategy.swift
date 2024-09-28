//
//  CxjToastAnimator+DefaultCenterConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	struct DefaultCenterConfigStrategy: DefaultConfigStrategy {
		let input: DefaultConfigStrategyInput
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			AnimatingProperties(
				alpha: .zero,
				scale: CxjToastAnimator.AnimatingProperties.Scale(x: 0.5, y: 0.5),
				translationY: .zero,
				cornerRadius: .zero,
				shadowIntensity: .zero
			)
		}
	}
}
