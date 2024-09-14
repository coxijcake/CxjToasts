//
//  CxjToastAnimator+LayoutUseCaseFactory.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

extension CxjToastAnimator {
	enum LayoutUseCaseFactory {
		static func animationLayoutUseCase(
			for toastView: ToastView,
			with config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues
		) -> AnimatorLayoutUseCase {
			switch config.layout.placement {
			case .top(verticalOffset: let verticalOffset):
				TopPlacementAnimatorLayoutUseCaseFactory.useCase(
					for: toastView,
					with: config,
                    toastViewDefaultValues: toastViewDefaultValues,
					verticalOffset: verticalOffset
				)
			case .center:
				CenterPlacementAnimatorUseCase(
					toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues
				)
			case .bottom(verticalOffset: let verticalOffset):
				BottomPlacementAnimatorUseCase(
					toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
