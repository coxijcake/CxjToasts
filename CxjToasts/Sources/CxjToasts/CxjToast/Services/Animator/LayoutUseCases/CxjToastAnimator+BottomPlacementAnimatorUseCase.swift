//
//  CxjToastAnimator+BottomPlacementAnimatorUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class BottomPlacementAnimatorUseCase: BaseLayoutUseCase, AnimatorLayoutUseCase {
		let verticalOffset: CGFloat
		
		init(
			toastView: ToastView,
            config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) {
			self.verticalOffset = verticalOffset
            super.init(
                toastView: toastView,
                config: config,
                toastViewDefaultValues: toastViewDefaultValues
            )
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			setDefaultToastViewValues()
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
            let sourceView: UIView = config.sourceView
			let toastSize: CGSize = toastView.bounds.size
			let sourceViewOffset: CGFloat = verticalOffset + sourceView.safeAreaInsets.bottom
			let fullTranslationY: CGFloat = toastSize.height + sourceViewOffset
			
			let baseScale: CGFloat = 1.0
			let fullScale: CGFloat = 0.75
			let scale = fullScale + ((baseScale - fullScale) * progress.revertedValue)
			let translationY = fullTranslationY * progress.value
			let transform = CGAffineTransform(scaleX: scale, y: scale)
						.concatenating(CGAffineTransform(translationX: .zero, y: translationY))
			
			toastView.transform = transform
		}
	}
}
