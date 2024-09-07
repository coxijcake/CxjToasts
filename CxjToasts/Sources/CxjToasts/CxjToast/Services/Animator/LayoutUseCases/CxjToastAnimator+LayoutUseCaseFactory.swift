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
			initialValues: InitialValues
		) -> AnimatorLayoutUseCase {
			switch config.layout.placement {
			case .top(verticalOffset: let verticalOffset):
				TopPlacementAnimatorLayoutUseCaseFactory.useCase(
					for: toastView,
					with: config,
					initialValues: initialValues,
					verticalOffset: verticalOffset
				)
			case .center:
				CenterPlacementAnimatorUseCase(
					toastView: toastView,
					sourceView: config.sourceView,
					initialValues: initialValues
				)
			case .bottom(verticalOffset: let verticalOffset):
				BottomPlacementAnimatorUseCase(
					toastView: toastView,
					sourceView: config.sourceView,
					initialValues: initialValues,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
