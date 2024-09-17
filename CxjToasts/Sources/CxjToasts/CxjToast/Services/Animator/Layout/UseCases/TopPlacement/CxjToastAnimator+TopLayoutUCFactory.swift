//
//  CxjToastAnimator+TopLayoutUseCaseFactory.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	enum TopLayoutUseCaseFactory {
		static func useCase(
			for toastView: ToastView,
			with config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) -> TopLayoutUseCase {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = config.sourceView.safeAreaInsets
            //TODO: - Think about removing
			let isSourceSafeAreaEqulWindowSafeArea: Bool = applicationSafeAreaInsets == sourceViewSafeAreaInsets
			
            return if config.animations.nativeViewsIncluding.contains(.dynamicIsland),
                      isSourceSafeAreaEqulWindowSafeArea,
                      CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
                TopDynamicIslandLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            } else if config.animations.nativeViewsIncluding.contains(.notch),
                      isSourceSafeAreaEqulWindowSafeArea,
                      CxjNotchHelper.isNotchInDefaultPosition {
                TopNotchLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            } else {
                TopDefaultLayoutUseCase(
                    toastView: toastView,
                    config: config,
                    toastViewDefaultValues: toastViewDefaultValues,
                    verticalOffset: verticalOffset
                )
            }
		}
	}
}
