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
		let input: ConfigStrategyCommonInput
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let yTranslation: CGFloat = dismissedTranslationY()
			
			return AnimatingProperties(
				alpha: .max,
				scale: .initial,
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: input.presentedStateAnimatingProperties.cornerRadius,
				shadowOverlay: .off
			)
		}
		
		private func dismissedTranslationY() -> CGFloat {
			let translationY: CGFloat =
			verticalOffset
			+ input.sourceViewData.safeAreaInsets.bottom
			+ input.toastViewData.size.height
			
			return translationY
		}
	}
}
