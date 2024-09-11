//
//  TopPlacementNotchLayoutUseCase.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopPlacementNotchLayoutUseCase: TopPlacementAnimatorLayoutUseCase {
		let toastView: ToastView
		let sourceView: UIView
		let initialValues: InitialValues
		let verticalOffset: CGFloat
		
		private var transitionAnimationDimmedView: UIView?
		
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
			addTransitionDimmedView()
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			toastView.transform = initialValues.transform
			toastView.alpha = initialValues.alpha
			toastView.layer.cornerRadius = initialValues.cornerRadius
			transitionAnimationDimmedView?.alpha = .zero
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
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
			let cornerRadiusEnd: CGFloat = initialValues.cornerRadius
			let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
			let safeCornerRadius: CGFloat = min(toastSize.height * 0.5, interpolatedCornerRadius)
			
			let transitionAlphaStart: CGFloat = 1.0
			let transitionViewAlphaEnd: CGFloat = 0.0
			let interpolatedTransitionViewAlpha: CGFloat = transitionAlphaStart * progress.value + transitionViewAlphaEnd * progress.revertedValue
			
			transitionAnimationDimmedView?.backgroundColor = CxjNotchHelper.backgroundColor
			transitionAnimationDimmedView?.alpha = interpolatedTransitionViewAlpha
			
			toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
				.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
			
			toastView.layer.cornerRadius = safeCornerRadius
		}
		
		private func addTransitionDimmedView() {
			let view: UIView = .init(frame: toastView.bounds)
			view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			view.isUserInteractionEnabled = false
			view.backgroundColor = .clear
			view.alpha = 1.0
			
			toastView.addSubview(view)
			self.transitionAnimationDimmedView = view
		}
	}
}
