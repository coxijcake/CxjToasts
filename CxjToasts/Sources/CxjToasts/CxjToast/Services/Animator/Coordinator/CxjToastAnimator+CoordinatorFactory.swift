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
				alpha: toastView.alpha,
				scale: .initial,
				translationY: .zero,
				cornerRadius: toastView.layer.cornerRadius,
				shadowIntensity: .zero
			)
			
			let configStrategy: ConfigStrategy = ConfigStrategyFactory.configStrategy(
				for: config,
				toastSize: toastView.bounds.size,
				presentedStateAnimatingProperties: presentedStateAnimatingProperties
			)
			
			return CommonBehaviourCoordinator(
				toastView: toastView,
				initialAnimatingProperties: presentedStateAnimatingProperties,
				animationConfigStrategy: configStrategy
			)
		}
	}
}
