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
		let initialValues: InitialValues
		let verticalOffset: CGFloat
		
		init(
			toastView: ToastView,
			sourceView: UIView,
			initialValues: InitialValues,
			verticalOffset: CGFloat
		) {
			self.toastView = toastView
			self.sourceView = sourceView
			self.initialValues = initialValues
			self.verticalOffset = verticalOffset
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			toastView.transform = initialValues.transform
			toastView.alpha = initialValues.alpha
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
