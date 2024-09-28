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
			let yTranslation: CGFloat = dismissedTranslationY()
			
			return AnimatingProperties(
				alpha: .max,
				scale: .initial,
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: .zero,
				shadowIntensity: .min
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
