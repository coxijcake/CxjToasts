//
//  CxjToastAnimator+CenterPlacementAnimatorUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class CenterPlacementAnimatorUseCase: BaseLayoutUseCase, AnimatorLayoutUseCase {
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			setDefaultToastViewValues()
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
			let baseScale: CGFloat = 1.0
			let fullScale: CGFloat = 0.5
			let scale: CGFloat = fullScale + ((baseScale - fullScale) * progress.revertedValue)
			let alpha: CGFloat = progress.revertedValue
			
			toastView.transform = CGAffineTransform(scaleX: scale, y: scale)
			toastView.alpha = alpha
		}
	}
}
