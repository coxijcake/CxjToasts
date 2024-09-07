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
			initialValues: InitialValues,
			verticalOffset: CGFloat
		) -> TopPlacementAnimatorLayoutUseCase {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = config.sourceView.safeAreaInsets
			let isSourceSafeAreaEqulWindowSafeArea: Bool = applicationSafeAreaInsets == sourceViewSafeAreaInsets
			
			return if isSourceSafeAreaEqulWindowSafeArea,
					  CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
				TopPlacementDynamicIslandLayoutUseCase(
					toastView: toastView,
					sourceView: config.sourceView,
					initialValues: initialValues,
					verticalOffset: verticalOffset
				)
			} else if isSourceSafeAreaEqulWindowSafeArea,
					  CxjNotchHelper.isNotchInDefaultPosition {
				TopPlacementNotchLayoutUseCase(
					toastView: toastView,
					sourceView: config.sourceView,
					initialValues: initialValues,
					verticalOffset: verticalOffset
				)
			} else {
				TopPlacementDefaultLayoutUseCase(
					toastView: toastView,
					sourceView: config.sourceView,
					initialValues: initialValues,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
