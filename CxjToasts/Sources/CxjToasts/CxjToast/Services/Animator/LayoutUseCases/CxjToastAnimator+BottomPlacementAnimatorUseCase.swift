//
//  CxjToastAnimator+BottomPlacementAnimatorUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class BottomPlacementAnimatorUseCase: AnimatorLayoutUseCase {
		let toastView: ToastView
		let sourceView: UIView
		let toastViewDefaultValues: ToastViewDefaultValues
		let verticalOffset: CGFloat
		
		init(
			toastView: ToastView,
			sourceView: UIView,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) {
			self.toastView = toastView
			self.sourceView = sourceView
			self.toastViewDefaultValues = toastViewDefaultValues
			self.verticalOffset = verticalOffset
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			toastView.transform = toastViewDefaultValues.transform
			toastView.alpha = toastViewDefaultValues.alpha
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
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
