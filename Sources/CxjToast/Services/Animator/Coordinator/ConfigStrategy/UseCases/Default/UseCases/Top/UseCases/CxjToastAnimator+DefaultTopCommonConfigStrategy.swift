//
//  CxjToastAnimator+DefaultTopCommonConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct DefaultTopCommonConfigStrategy: CxjToastAnimationPropertiesConfigStrategy {
		let input: ConfigStrategyCommonInput
		let includingSafeArea: Bool
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> ToastAnimatingProperties {
			let yTranslation: CGFloat = dismissedTranslationY()
			
			return ToastAnimatingProperties(
				alpha: .max,
				scale: .initial,
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: input.presentedStateAnimatingProperties.cornerRadius,
				shadowOverlay: .off
			)
		}
		
		private func dismissedTranslationY() -> CGFloat {
			let safeAreaInset: CGFloat = includingSafeArea
			? input.sourceViewData.safeAreaInsets.top
			: .zero
			
			let translationY: CGFloat =
			verticalOffset
			+ safeAreaInset
			+ input.toastViewData.size.height
			
			return -translationY
		}
	}
}
