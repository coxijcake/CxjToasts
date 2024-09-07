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
			let notchSize: CGSize = CxjNotchHelper.notchSize
			
			let xScaleStart: CGFloat = min(notchSize.width, toastSize.width)
			/ max(notchSize.width, toastSize.width)
			let yScaleStart: CGFloat = min(notchSize.height, toastSize.height)
			/ max(notchSize.height, toastSize.height)
			
			let baseScale: CGFloat = 1.0
			let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
			let yScale: CGFloat = yScaleStart + (baseScale - yScaleStart) * progress.revertedValue
			
			let yTranslation: CGFloat = sourceView.safeAreaInsets.top
			+ toastView.bounds.size.height
			+ verticalOffset
			- notchSize.height * 2
			
			let interpolatedYTranslation = -yTranslation * progress.value
			
			let cornerRadiusStart: CGFloat = CxjNotchHelper.estimatedCornerRadius
			let cornerRadiusEnd: CGFloat = initialValues.cornerRadius
			let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
			
			let transitionAlphaStart: CGFloat = 0.75
			let transitionViewAlphaEnd: CGFloat = 0.0
			let interpolatedTransitionViewAlpha: CGFloat = transitionAlphaStart * progress.value + transitionViewAlphaEnd * progress.revertedValue
			
			transitionAnimationDimmedView?.backgroundColor = CxjNotchHelper.backgroundColor
			transitionAnimationDimmedView?.alpha = interpolatedTransitionViewAlpha
			
			toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
				.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
			
			toastView.layer.cornerRadius = interpolatedCornerRadius
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
