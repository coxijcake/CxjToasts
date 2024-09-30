//
//  CxjToastAnimator+DefaultTopNotchConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct DefaultTopNotchConfigStrategy: DefaultTopConfigStrategy {
		let input: DefaultConfigStrategyInput
		let verticalOffset: CGFloat
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let yTranslation: CGFloat = getDismissedYTranslation()
			
			return AnimatingProperties(
				alpha: .max,
				scale: getDismissedScale(),
				translation: .init(x: .zero, y: yTranslation),
				cornerRadius: dismissedCornerRadius(),
				shadow: dismissedShadow()
			)
		}
		
		private func getDismissedScale() -> AnimatingProperties.Scale {
			let toastSize: CGSize = input.toastSize
			let notchSize: CGSize = CxjNotchHelper.notchSize
			
			let xScale: CGFloat =
			min(notchSize.width, toastSize.width)
			/ max(notchSize.width, toastSize.width)
			
			let yScale: CGFloat =
			min(notchSize.height, toastSize.height)
			/ max(notchSize.height, toastSize.height)
			
			return .init(x: xScale, y: yScale)
		}
		
		private func getDismissedYTranslation() -> CGFloat {
			let topSafeArea: CGFloat = input.sourceViewSafeAreaInsets.top
			
			let yTranslation: CGFloat =
			verticalOffset
			+ topSafeArea
			- (topSafeArea - CxjDynamicIslandHelper.estimatedMinHeight)
			
			return -yTranslation
		}
		
		private func dismissedCornerRadius() -> AnimatingProperties.CornerRadius {
			AnimatingProperties.CornerRadius(
				value: CxjNotchHelper.estimatedBottomCornerRadius,
				constraint: .halfHeight
			)
		}
		
		private func dismissedShadow() -> AnimatingProperties.Shadow {
			AnimatingProperties.Shadow.on(
				color: CxjNotchHelper.backgroundColor,
				alpha: .max
			)
		}
	}
}
