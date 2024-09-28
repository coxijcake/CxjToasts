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
			presentedStateAnimatingProperties: AnimatingProperties
		) -> ConfigStrategy {
			switch config.animations.behaviour {
			case .default:
				DefaultConfigStrategyFactory.configStrategy(
					placement: config.layout.placement,
					input: DefaultConfigStrategyInput(
						toastSize: toastSize,
						sourceViewSafeAreaInsets: config.sourceView.safeAreaInsets
					)
				)
			case .custom(let changes):
				CustomConfigStrategy(
					presentedStateAnimatingProperties: presentedStateAnimatingProperties,
					changes: changes
				)
			}
		}
	}
}
