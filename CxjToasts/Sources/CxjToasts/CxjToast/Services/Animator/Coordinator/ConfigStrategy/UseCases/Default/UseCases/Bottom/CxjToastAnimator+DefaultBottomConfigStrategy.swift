//
//  CxjToastAnimator+DefaultBottomConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct DefaultBottomConfigStrategy: DefaultConfigStrategy {
		let input: DefaultConfigStrategyInput
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let yTranslation: CGFloat = dismissedTranslationY()
			
			return AnimatingProperties(
				alpha: 1.0,
				scale: .initial,
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: .zero,
				shadowIntensity: .zero
			)
		}
		
		private func dismissedTranslationY() -> CGFloat {
			let translationY: CGFloat =
			verticalOffset
			+ input.sourceViewSafeAreaInsets.bottom
			+ input.toastSize.height
			
			return translationY
		}
	}
}
