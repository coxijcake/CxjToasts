//
//  CxjToastAnimator+LayouterFactory.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

extension CxjToastAnimator {
	enum CoordinatorConfigurator {
		static func coordinator(
			for toastView: ToastView,
			with config: ToastConfig
		) -> Coordinator {
			let presentedStateAnimatingProperties: AnimatingProperties =  AnimatingProperties(
				alpha: .init(value: toastView.alpha),
				scale: .initial,
				translation: .initial,
				cornerRadius: .init(value: toastView.layer.cornerRadius, constraint: .none),
				shadowOverlay: .off
			)
			
			let configStrategy: ConfigStrategy = ConfigStrategyFactory.configStrategy(
				for: config,
				toastSize: toastView.bounds.size,
				presentedStateAnimatingProperties: presentedStateAnimatingProperties
			)
			
			return CommonBehaviourCoordinator(
				toastView: toastView,
				presentedStateAnimatingProperties: presentedStateAnimatingProperties,
				animationConfigStrategy: configStrategy
			)
		}
	}
}
