//
//  CxjToastAnimator+ConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import UIKit

extension CxjToastAnimator {
	@MainActor
	enum ConfigStrategyFactory {
		static func configStrategyFor(
			animation: ConfigAnimation,
			placement: Placement,
			layoutData: LayoutData,
			presentedStateAnimatingProperties: ToastAnimatingProperties
		) -> ConfigStrategy {
			let commonInput: ConfigStrategyCommonInput = ConfigStrategyCommonInput(
				presentedStateAnimatingProperties: presentedStateAnimatingProperties,
				toastViewData: CxjToastAnimator.ConfigStrategyCommonInput.ToastViewData(
					size: layoutData.toastView.size,
					placement: placement
				),
				sourceViewData: CxjToastAnimator.ConfigStrategyCommonInput.SourceViewData(
					frame: layoutData.sourceView.frame,
					safeAreaInsets: layoutData.sourceView.safeAreaInsets
				)
			)
			
			return switch animation.behaviour {
			case .default(includingNativeViews: let inculdedCustomViews):
				DefaultConfigStrategyFactory.configStrategy(
					placement: placement,
					usingAnimationNativeViews: inculdedCustomViews,
					input: commonInput
				)
			case .custom(let changes):
				CustomConfigStrategy(
					input: commonInput,
					presentedStateAnimatingProperties: presentedStateAnimatingProperties,
					changes: changes
				)
			}
		}
	}
}
