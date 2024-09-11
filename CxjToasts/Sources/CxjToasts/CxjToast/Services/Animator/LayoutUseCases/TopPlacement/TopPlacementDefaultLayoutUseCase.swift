//
//  TopPlacementDefaultLayoutUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopPlacementDefaultLayoutUseCase: TopPlacementAnimatorLayoutUseCase {
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
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
			let sourceViewOffset: CGFloat = verticalOffset + sourceView.safeAreaInsets.top
			let fullTranslationY: CGFloat = toastView.bounds.size.height + sourceViewOffset
			
			let baseScale: CGFloat = 1.0
			let fullScale: CGFloat = 0.5
			let scale = fullScale + ((baseScale - fullScale) * progress.revertedValue)
			let translationY: CGFloat = -fullTranslationY * progress.value
			let transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
				.concatenating(CGAffineTransform(translationX: .zero, y: translationY))
			
			toastView.transform = transform
		}
	}
}
