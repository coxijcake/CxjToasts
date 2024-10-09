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
		let includingSafeArea: Bool
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
			let safeAreaInset: CGFloat = includingSafeArea
			? input.sourceViewData.safeAreaInsets.bottom
			: .zero
			
			let translationY: CGFloat =
			verticalOffset
			+ safeAreaInset
			+ input.toastViewData.size.height
			
			return translationY
		}
	}
}
