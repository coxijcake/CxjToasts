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
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let yTranslation: CGFloat = dismissYTranslation()
			
			return AnimatingProperties(
				alpha: .max,
				scale: dissmisScale(),
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: dismissedCornerRadius(),
				shadowOverlay: dismissedShadow()
			)
		}
		
		private func dissmisScale() -> AnimatingProperties.Scale {
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
		
		private func dismissedCornerRadius() -> AnimatingProperties.CornerRadius {
			AnimatingProperties.CornerRadius(
				value: CxjDynamicIslandHelper.cornerRadius,
				constraint: .halfHeight
			)
		}
		
		private func dismissedShadow() -> AnimatingProperties.ShadowOverlay {
			AnimatingProperties.ShadowOverlay.on(
				color: CxjDynamicIslandHelper.backgroundColor,
				alpha: .max
			)
		}
	}
}
