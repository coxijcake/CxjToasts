//
//  CxjToastAnimator.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastAnimator {
    typealias ToastView = CxjToastView
    typealias ToastConfig = CxjToastConfiguration
	typealias Placement = ToastConfig.Layout.Placement
    typealias Animations = ToastConfig.Animations
    typealias AnimationsChanges = Animations.Changes
    typealias AnimationsAction = CxjAnimation.Animations
    typealias AnimationsCompletion = CxjAnimation.Completion
    
    struct ToastViewDefaultValues {
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
        
        static var base: ToastViewDefaultValues {
            ToastViewDefaultValues(
                alpha: 1.0,
                transform: .identity,
                cornerRadius: .zero,
                borderWidth: .zero,
                borderColor: nil
            )
        }
    }
}

final class CxjToastAnimator {
	//MARK: - Props
	private let toastView: ToastView
	private let config: ToastConfig
    private var toastViewDefaultValues: ToastViewDefaultValues = .base
	
	private lazy var layoutUseCase: AnimatorLayoutUseCase = LayoutUseCaseFactory
		.animationLayoutUseCase(
			for: toastView,
			with: config,
            toastViewDefaultValues: toastViewDefaultValues
		)
	
    init(toastView: ToastView, config: ToastConfig) {
        self.toastView = toastView
        self.config = config
    }
}

//MARK: - Present Animator
extension CxjToastAnimator: CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation {
        config.animations.present
    }
    
	func presentAction(completion: AnimationsCompletion?) {
        let fullProgress: ToastLayoutProgress = ToastLayoutProgress(value: 1.0)
        
        toastViewDefaultValues = ToastViewDefaultValues(toastView: toastView)
		layoutUseCase.beforeDisplayingLayout(progress: fullProgress)
		
		let animations: AnimationsAction = {
			self.layoutUseCase.presentingLayout()
		}
		
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
		config.animations.dismiss
	}
	
	func dismissAction(
		progress: CGFloat,
		animated: Bool,
		completion: AnimationsCompletion?
	) {
		let progress: ToastLayoutProgress = ToastLayoutProgress(value: progress)
		let animations: AnimationsAction = {
			self.layoutUseCase.dismissLayout(progress: progress)
		}
		
		UIView.animate(
			with: animated ? dismissAnimation : .noAnimation,
			animations: animations,
			completion: completion
		)
	}
}
