//
//  TopPlacementAnimatorLayoutUseCaseFactory.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	enum TopPlacementAnimatorLayoutUseCaseFactory {
		static func useCase(
			for toastView: ToastView,
			with config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) -> TopPlacementAnimatorLayoutUseCase {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = config.sourceView.safeAreaInsets
            //TODO: - Think about removing
			let isSourceSafeAreaEqulWindowSafeArea: Bool = applicationSafeAreaInsets == sourceViewSafeAreaInsets
			
            return if config.animations.nativeViewsIncluding.contains(.dynamicIsland),
                      isSourceSafeAreaEqulWindowSafeArea,
                      CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
                TopPlacementDynamicIslandLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            } else if config.animations.nativeViewsIncluding.contains(.notch),
                      isSourceSafeAreaEqulWindowSafeArea,
                      CxjNotchHelper.isNotchInDefaultPosition {
                TopPlacementNotchLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            } else {
                TopPlacementDefaultLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            }
		}
	}
}
