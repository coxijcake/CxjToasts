//
//  CxjToastAnimator+DefaultTopCommonConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct DefaultTopCommonConfigStrategy: DefaultTopConfigStrategy {
		let input: DefaultConfigStrategyInput
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			AnimatingProperties(
				alpha: 1.0,
				scale: .initial,
				translationY: dismissedTranslationY(),
				cornerRadius: .zero,
				shadowIntensity: .zero
			)
		}
		
		private func dismissedTranslationY() -> CGFloat {
			let translationY: CGFloat =
			verticalOffset
			+ input.sourceViewSafeAreaInsets.top
			+ input.toastSize.height
			
			return -translationY
		}
	}
}
