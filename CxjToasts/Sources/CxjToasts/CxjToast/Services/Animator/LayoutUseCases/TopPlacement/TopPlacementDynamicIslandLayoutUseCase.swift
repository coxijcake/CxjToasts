//
//  TopPlacementDynamicIslandLayoutUseCase.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopPlacementDynamicIslandLayoutUseCase: TopPlacementAnimatorLayoutUseCase {
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
			toastView.layer.borderWidth = initialValues.borderWidth
			toastView.layer.borderColor = initialValues.borderColor
			transitionAnimationDimmedView?.alpha = .zero
		}
		
		func dismissLayout(progress: ToastLayoutProgress) {
			let toastSize: CGSize = toastView.bounds.size
			let islandWidth: CGFloat = CxjDynamicIslandHelper.minWidth
			let islandHeight: CGFloat = CxjDynamicIslandHelper.estimatedMinHeight
			
			let xScaleStart: CGFloat = min(islandWidth, toastSize.width) / max(islandWidth, toastSize.width)
			let yScaleStart: CGFloat = min(islandHeight, toastSize.height) / max(islandHeight, toastSize.height)
			
			let baseScale: CGFloat = 1.0
			let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
			let yScale: CGFloat = yScaleStart + (baseScale - yScaleStart) * progress.revertedValue
            
            let originalHeight = toastSize.height
            let scaledHeight = originalHeight * yScale
			
            let yTranslation: CGFloat =
            verticalOffset
            + CxjDynamicIslandHelper.estimatedMinHeight
            + CxjDynamicIslandHelper.estimatedBottomOffset
			
			let interpolatedYTranslation =
            -yTranslation
            * progress.value
            - ((originalHeight - scaledHeight) / 2)
            
			let cornerRadiusStart: CGFloat = CxjDynamicIslandHelper.cornerRadius
			let cornerRadiusEnd: CGFloat = initialValues.cornerRadius
			let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
			let safeCornerRadius: CGFloat = min(toastSize.height * 0.5, interpolatedCornerRadius)
			
			let borderAlphaStart: CGFloat = 1.0
			let borderAlphaEnd: CGFloat = 0.0
			let interpolatedBorderAlpha: CGFloat = borderAlphaStart * progress.value + borderAlphaEnd * progress.revertedValue
			
			let transitionAlphaStart: CGFloat = 0.75
			let transitionViewAlphaEnd: CGFloat = 0.0
			let interpolatedTransitionViewAlpha: CGFloat = transitionAlphaStart * progress.value + transitionViewAlphaEnd * progress.revertedValue
			
			transitionAnimationDimmedView?.backgroundColor = CxjDynamicIslandHelper.backgroundColor
			transitionAnimationDimmedView?.alpha = interpolatedTransitionViewAlpha
			
			toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
				.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
			
			toastView.layer.cornerRadius = safeCornerRadius
			toastView.layer.borderColor = CxjDynamicIslandHelper.backgroundColor.withAlphaComponent(interpolatedBorderAlpha).cgColor
			toastView.layer.borderWidth = 2
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