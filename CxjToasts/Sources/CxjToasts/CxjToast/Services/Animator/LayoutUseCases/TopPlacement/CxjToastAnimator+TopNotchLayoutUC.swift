//
//  CxjToastAnimator+TopNotchLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopNotchLayoutUseCase: BaseLayoutUseCase, TopLayoutUseCase {
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
			addTransitionDimmedView()
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
            setDefaultToastViewValues()
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
            let sourceView: UIView = config.sourceView
			let toastSize: CGSize = toastView.bounds.size
            let adjustedNotchSize: CGSize = CGSize(
                width: CxjNotchHelper.notchSize.width,
                height: CxjNotchHelper.notchSize.height + 6
            )
			
			let xScaleStart: CGFloat =
            min(adjustedNotchSize.width, toastSize.width)
			/ max(adjustedNotchSize.width, toastSize.width)
            
			let yScaleStart: CGFloat =
            min(adjustedNotchSize.height, toastSize.height)
			/ max(adjustedNotchSize.height, toastSize.height)
			
			let baseScale: CGFloat = 1.0
            let additionalYScale: CGFloat = 0.0
			let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
			let yScale: CGFloat = (yScaleStart + (baseScale - yScaleStart) * progress.revertedValue) + additionalYScale
            
            let originalHeight = toastSize.height
            let scaledHeight = originalHeight * yScale
			
            let yTranslation: CGFloat =
            verticalOffset
            + sourceView.safeAreaInsets.top
			
			let interpolatedYTranslation = 
            -yTranslation
            * progress.value
            - ((originalHeight - scaledHeight) / 2)
			
			let cornerRadiusStart: CGFloat = CxjNotchHelper.estimatedBottomCornerRadius
			let cornerRadiusEnd: CGFloat = toastViewDefaultValues.cornerRadius
			let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
			
			let transitionAlphaStart: CGFloat = 1.0
			let transitionViewAlphaEnd: CGFloat = 0.0
			let interpolatedTransitionViewAlpha: CGFloat = transitionAlphaStart * progress.value + transitionViewAlphaEnd * progress.revertedValue
			            
			toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
				.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
			
			toastView.layer.cornerRadius = interpolatedCornerRadius
            
            transitionAnimationDimmedView?.backgroundColor = CxjNotchHelper.backgroundColor
            transitionAnimationDimmedView?.alpha = interpolatedTransitionViewAlpha
            transitionAnimationDimmedView?.layer.cornerRadius = interpolatedCornerRadius
		}
	}
}
