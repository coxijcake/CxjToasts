//
//  CxjToastAnimator.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastAnimator {
    typealias Animation = CxjToastConfiguration.Animations.AnimationConfig
    typealias ToastView = CxjToastView
    typealias ToastConfig = CxjToastConfiguration
    typealias AnimationsAction = CxjAnimation.Animations
    typealias AnimationsCompletion = CxjAnimation.Completion
    
    struct InitialValues {
        let alpha: CGFloat
        let transform: CGAffineTransform
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let borderColor: CGColor?
        
        init(
            alpha: CGFloat,
            transform: CGAffineTransform,
            cornerRadius: CGFloat,
            borderWidth: CGFloat,
            borderColor: CGColor?
        ) {
            self.alpha = alpha
            self.transform = transform
            self.cornerRadius = cornerRadius
            self.borderWidth = borderWidth
            self.borderColor = borderColor
        }
        
        init(toastView: ToastView) {
            self.init(
                alpha: toastView.alpha,
                transform: toastView.transform,
                cornerRadius: toastView.layer.cornerRadius,
                borderWidth: toastView.layer.borderWidth,
                borderColor: toastView.layer.borderColor
            )
        }
    }
}

final class CxjToastAnimator {
	//MARK: - Props
	let toastView: ToastView
	let config: ToastConfig
    let initialValues: InitialValues
	
    init(toastView: ToastView, config: ToastConfig) {
        self.toastView = toastView
        self.config = config
        self.initialValues = InitialValues(toastView: toastView)
    }
}

//MARK: - Present Animator
extension CxjToastAnimator: CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation {
        config.animations.present.animation
    }
    
	func presentAction(completion: AnimationsCompletion?) {
		let fullProgress: ToastLayoutProgress = ToastLayoutProgress(value: 1.0)
		setupBeforeDisplayingState(with: config, progress: fullProgress)
		
		let animations: AnimationsAction = presentAnimationAction(for: config)
		
		UIView.animate(
			with: presentAnimation,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Dismiss Aniamtor
extension CxjToastAnimator: CxjToastDismissAnimator {
	var dismissAnimation: CxjAnimation {
		config.animations.dismiss.animation
	}
	
	func dismissAction(
		progress: CGFloat,
		animated: Bool,
		completion: AnimationsCompletion?
	) {
		let progress: ToastLayoutProgress = ToastLayoutProgress(value: progress)
		let animations: AnimationsAction = dismissAnimationAction(
			for: config,
			progress: progress
		)
		
		UIView.animate(
			with: animated ? dismissAnimation : .noAnimation,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Private
private extension CxjToastAnimator {	
	func setupBeforeDisplayingState(with config: ToastConfig, progress: ToastLayoutProgress) {
		let toastSize: CGSize = toastView.bounds.size
		
		switch config.layout.placement {
		case .top(vericalOffset: let verticalOffset):
			setupBeforeDisplayingFromTopState(verticalOffset: verticalOffset, progress: progress)
		case .bottom(verticalOffset: let verticalOffset):
			let sourceViewOffset: CGFloat = verticalOffset + config.sourceView.safeAreaInsets.bottom
			let fullTranslationY: CGFloat = toastSize.height + sourceViewOffset
			
			let baseScale: CGFloat = 1.0
			let fullScale: CGFloat = 0.75
			let scale = fullScale + ((baseScale - fullScale) * progress.revertedValue)
			let translationY = fullTranslationY * progress.value
			let transform = CGAffineTransform(scaleX: scale, y: scale)
						.concatenating(CGAffineTransform(translationX: .zero, y: translationY))
			
			toastView.transform = transform
		case .center:
			let baseScale: CGFloat = 1.0
			let fullScale: CGFloat = 0.5
			let scale: CGFloat = fullScale + ((baseScale - fullScale) * progress.revertedValue)
			let alpha: CGFloat = progress.revertedValue
			
			toastView.transform = CGAffineTransform(scaleX: scale, y: scale)
			toastView.alpha = alpha
		}
	}
	
	func presentAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			self.toastView.transform = self.initialValues.transform
			self.toastView.alpha = self.initialValues.alpha
			self.toastView.layer.cornerRadius = self.initialValues.cornerRadius
			self.toastView.layer.borderWidth = self.initialValues.borderWidth
			self.toastView.layer.borderColor = self.initialValues.borderColor
		}
		
		return animations
	}
	
	func dismissAnimationAction(for config: ToastConfig, progress: ToastLayoutProgress) -> AnimationsAction {
		let animations: AnimationsAction = {
			self.setupBeforeDisplayingState(with: config, progress: progress)
		}
		
		return animations
	}
    
	func setupBeforeDisplayingFromTopState(verticalOffset: CGFloat, progress: ToastLayoutProgress) {
        let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
        let sourceViewSafeAreaInsets: UIEdgeInsets = config.sourceView.safeAreaInsets
		        
        if applicationSafeAreaInsets == sourceViewSafeAreaInsets,
           CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
			setupBeforeDisplayingFromTopDynamicIsnandState(
				verticalOffset: verticalOffset,
				progress: progress
			)
        } else if applicationSafeAreaInsets == sourceViewSafeAreaInsets,
				  CxjNotchHelper.isNotchInDefaultPosition {
			setupBeforeDisplayinFromTopNotchState(
				verticalOffset: verticalOffset,
				progress: progress
			)
		} else {
			let sourceViewOffset: CGFloat = verticalOffset + config.sourceView.safeAreaInsets.top
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
	
	func setupBeforeDisplayinFromTopNotchState(verticalOffset: CGFloat, progress: ToastLayoutProgress) {
		let toastSize: CGSize = toastView.bounds.size
		let notchSize: CGSize = CxjNotchHelper.notchSize
		
		let xScaleStart: CGFloat = min(notchSize.width, toastSize.width)
		/ max(notchSize.width, toastSize.width)
		let yScaleStart: CGFloat = min(notchSize.height, toastSize.height)
		/ max(notchSize.height, toastSize.height)
		
		let baseScale: CGFloat = 1.0
		let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
		let yScale: CGFloat = yScaleStart + (baseScale - yScaleStart) * progress.revertedValue
		
		let yTranslation: CGFloat = config.sourceView.safeAreaInsets.top
		+ toastView.bounds.size.height
		+ verticalOffset
		- notchSize.height * 2
		
		let interpolatedYTranslation = -yTranslation * progress.value
		
		let cornerRadiusStart: CGFloat = CxjNotchHelper.estimatedCornerRadius
		let cornerRadiusEnd: CGFloat = initialValues.cornerRadius
		let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
		
		toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
			.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
		
		toastView.layer.cornerRadius = interpolatedCornerRadius
	}
    
	func setupBeforeDisplayingFromTopDynamicIsnandState(verticalOffset: CGFloat, progress: ToastLayoutProgress) {
        let toastSize: CGSize = toastView.bounds.size
        let islandWidth: CGFloat = CxjDynamicIslandHelper.minWidth
        let islandHeight: CGFloat = CxjDynamicIslandHelper.estimatedMinHeight
        		
		let xScaleStart: CGFloat = min(islandWidth, toastSize.width) / max(islandWidth, toastSize.width)
		let yScaleStart: CGFloat = min(islandHeight, toastSize.height) / max(islandHeight, toastSize.height)
		
		let baseScale: CGFloat = 1.0
		let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
		let yScale: CGFloat = yScaleStart + (baseScale - yScaleStart) * progress.revertedValue
		
		let yTranslation: CGFloat = config.sourceView.safeAreaInsets.top
		+ toastView.bounds.size.height
		+ verticalOffset
		- CxjDynamicIslandHelper.topOffset
		- CxjDynamicIslandHelper.estimatedMinHeight
		
		let interpolatedYTranslation = -yTranslation * progress.value
		
		toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
			.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
		
		let cornerRadiusStart: CGFloat = CxjDynamicIslandHelper.cornerRadius
		let cornerRadiusEnd: CGFloat = initialValues.cornerRadius
		
		let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
		toastView.layer.cornerRadius = interpolatedCornerRadius
		
		let borderAlphaStart: CGFloat = 1.0
		let borderAlphaEnd: CGFloat = 0.0
		
		let interpolatedBorderAlpha: CGFloat = borderAlphaStart * progress.value + borderAlphaEnd * progress.revertedValue
		
		toastView.layer.borderColor = CxjDynamicIslandHelper.backgroundColor.withAlphaComponent(interpolatedBorderAlpha).cgColor
		toastView.layer.borderWidth = 5 * progress.value
    }
}
