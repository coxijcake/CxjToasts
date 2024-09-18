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
			with config: ToastConfig
		) -> LayoutUseCase {
			switch config.layout.placement {
			case .top(verticalOffset: let verticalOffset):
				TopLayoutUseCaseFactory.useCase(
					for: toastView,
					with: config,
					verticalOffset: verticalOffset
				)
			case .center:
				CenterLayoutUseCase(
					toastView: toastView,
                    config: config
				)
			case .bottom(verticalOffset: let verticalOffset):
				BottomLayoutUseCase(
					toastView: toastView,
                    config: config,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
