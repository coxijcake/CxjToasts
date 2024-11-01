//
//  CxjToastAnimator+DefaultTopDynamicIslandConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	struct DefaultTopDynamicIslandConfigStrategy: DefaultTopConfigStrategy {
		let input: ConfigStrategyCommonInput
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> ToastAnimatingProperties {
			let yTranslation: CGFloat = dismissYTranslation()
			
			return ToastAnimatingProperties(
				alpha: .max,
				scale: dismissScale(),
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: dismissedCornerRadius(),
				shadowOverlay: dismissedShadow()
			)
		}
		
		private func dismissScale() -> ToastAnimatingProperties.Scale {
			let toastSize: CGSize = input.toastViewData.size
			let dynamicIslandAdjustedSize: CGSize = CGSize(
				width: CxjDynamicIslandHelper.minWidth - 6,
				height: CxjDynamicIslandHelper.estimatedMinHeight - 4
			)
			
			let xScale: CGFloat =
			min(dynamicIslandAdjustedSize.width, toastSize.width)
			/ max(dynamicIslandAdjustedSize.width, toastSize.width)
			
			let yScale: CGFloat =
			min(dynamicIslandAdjustedSize.height, toastSize.height)
			/ max(dynamicIslandAdjustedSize.height, toastSize.height)
			
			return .init(x: xScale, y: yScale)
		}
		
		private func dismissYTranslation() -> CGFloat {
			let yTranslation: CGFloat =
			verticalOffset
			+ CxjDynamicIslandHelper.estimatedMinHeight
			+ CxjDynamicIslandHelper.estimatedBottomOffset
			
			return -yTranslation
		}
		
		private func dismissedCornerRadius() -> ToastAnimatingProperties.CornerRadius {
			ToastAnimatingProperties.CornerRadius(
				value: CxjDynamicIslandHelper.cornerRadius,
				constraint: .halfHeight
			)
		}
		
		private func dismissedShadow() -> ToastAnimatingProperties.ShadowOverlay {
			ToastAnimatingProperties.ShadowOverlay.on(
				color: CxjDynamicIslandHelper.backgroundColor,
				alpha: .max
			)
		}
	}
}
