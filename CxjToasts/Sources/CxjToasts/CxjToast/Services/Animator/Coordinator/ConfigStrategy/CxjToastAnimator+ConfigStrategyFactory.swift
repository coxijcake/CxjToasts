//
//  CxjToastAnimator+ConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	enum ConfigStrategyFactory {
		static func configStrategy(
			for config: ToastConfig,
			toastSize: CGSize,
			presentedStateAnimatingProperties: ToastAnimatingProperties
		) -> ConfigStrategy {
			let commonInput: ConfigStrategyCommonInput = ConfigStrategyCommonInput(
				presentedStateAnimatingProperties: presentedStateAnimatingProperties,
				toastViewData: CxjToastAnimator.ConfigStrategyCommonInput.ToastViewData(
					size: toastSize,
					placement: config.layout.placement
				),
				sourceViewData: CxjToastAnimator.ConfigStrategyCommonInput.SourceViewData(
					frame: config.sourceView.frame,
					safeAreaInsets: config.sourceView.safeAreaInsets
				)
			)
			
			return switch config.animations.behaviour {
			case .default:
				DefaultConfigStrategyFactory.configStrategy(
					placement: config.layout.placement,
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
