//
//  CxjToastAnimator.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

struct CxjToastAnimator {
	//MARK: - Types
	typealias Animation = CxjToastConfiguration.Animations.AnimationConfig
	typealias ToastView = CxjToastView
	typealias ToastConfig = CxjToastConfiguration
	typealias AnimationsAction = CxjAnimation.Animations
	typealias AnimationsCompletion = CxjAnimation.Completion
	
	//MARK: - Props
	let toastView: ToastView
	let config: ToastConfig
}

//MARK: - Present Animator
extension CxjToastAnimator: CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation {
        config.animations.present.animation
    }
    
	func showAction(completion: AnimationsCompletion?) {
		setupBeforeDisplayingState(with: config)
		
		let animations: AnimationsAction = showAnimationAction(for: config)
		
		UIView.animate(
			with: showAnimation.animation,
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
	
	func dismissAction(completion: AnimationsCompletion?) {
		let animations: AnimationsAction = hideAnimationAction(for: config)
		
		UIView.animate(
			with: hideAnimation.animation,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Private
private extension CxjToastAnimator {
	var showAnimation: Animation {
		config.animations.present
	}
	
	var hideAnimation: Animation {
		config.animations.dismiss
	}
	
	func setupBeforeDisplayingState(with config: ToastConfig) {
		let toastSize: CGSize = toastView.bounds.size
		
		switch config.layout.placement {
		case .top(vericalOffset: let verticalOffset):
			let sourceViewOffset: CGFloat = verticalOffset + config.sourceView.safeAreaInsets.top
			let translationY: CGFloat = toastSize.height + sourceViewOffset
			toastView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
				.concatenating(CGAffineTransform(translationX: .zero, y: -translationY))
		case .bottom(verticalOffset: let verticalOffset):
			let sourceViewOffset: CGFloat = verticalOffset + config.sourceView.safeAreaInsets.bottom
			let translationY: CGFloat = toastSize.height + sourceViewOffset
			toastView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
				.concatenating(CGAffineTransform(translationX: .zero, y: translationY))
		case .center:
			toastView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
			toastView.alpha = .zero
		}
	}
	
	func showAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			toastView.transform = .identity
			toastView.alpha = 1.0
		}
		
		return animations
	}
	
	func hideAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			setupBeforeDisplayingState(with: config)
		}
		
		return animations
	}
}
