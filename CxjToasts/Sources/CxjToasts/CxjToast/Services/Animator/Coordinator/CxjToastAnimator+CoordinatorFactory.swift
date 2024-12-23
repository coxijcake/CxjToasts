//
//  CxjToastAnimator+LayouterFactory.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	@MainActor
	enum CoordinatorConfigurator {
		static func coordinator(
			forToastView toastView: ToastView,
			sourceBackground: SourceBackground?,
			animation: ConfigAnimation,
			layoutData: LayoutData,
			placement: Placement
		) -> Coordinator {
			let presentedStateAnimatingProperties: ToastAnimatingProperties =  ToastAnimatingProperties(
				alpha: .init(value: toastView.alpha),
				scale: .initial,
				translation: .initial,
				cornerRadius: .init(value: toastView.layer.cornerRadius, constraint: .none),
				shadowOverlay: .off
			)
			
			let presentedStateSourceBackgroundAnimatingProperies: SourceBackgroundAnimatingProperties = SourceBackgroundAnimatingProperties(
				alpha: .max
			)
			
			let dismissedStateSourceBackgroundAnimatingProperties: SourceBackgroundAnimatingProperties = SourceBackgroundAnimatingProperties(
				alpha: .min
			)
			
			let configStrategy: ConfigStrategy = ConfigStrategyFactory
				.configStrategyFor(
					animation: animation,
					placement: placement,
					layoutData: layoutData,
					presentedStateAnimatingProperties: presentedStateAnimatingProperties
				)
			
			let toastLayoutCalculator: ToastLayoutCalculator = ToastLayoutCalculator(
				presentedStateProps: presentedStateAnimatingProperties,
				dismissedStateProps: configStrategy.dismissedStateAnimatingProperties(),
                toastSize: toastView.bounds.size,
                cornerRadiusProgressSmoothing: 0.3
			)
			
			let sourceBackgroundLayoutCalculator: SourceBackgroundLayoutCalculator = SourceBackgroundLayoutCalculator(
				presentedStateProps: presentedStateSourceBackgroundAnimatingProperies,
				dismissedStateProps: dismissedStateSourceBackgroundAnimatingProperties
			)
			
			return CommonBehaviourCoordinator(
				toastView: toastView,
				sourceBackground: sourceBackground,
				toastLayoutCalculator: toastLayoutCalculator,
				sourceBackgroundLayoutCalculator: sourceBackgroundLayoutCalculator
			)
		}
	}
}
