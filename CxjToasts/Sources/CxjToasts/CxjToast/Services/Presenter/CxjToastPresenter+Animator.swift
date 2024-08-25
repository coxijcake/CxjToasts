//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

extension CxjToastPresenter {
	struct ToastAnimator {
		//MARK: - Types
		typealias Animation = CxjToastConfiguration.Animations.Animation
		typealias ToastView = CxjToastView
		typealias ToastConfig = CxjToastConfiguration
		typealias AnimationsAction = CxjAnimator.Animations
		typealias AnimationsCompletion = CxjAnimator.Completion
		
		//MARK: - Props
		let toastView: ToastView
		let config: ToastConfig
	}
}

//MARK: - Public API
extension CxjToastPresenter.ToastAnimator {
	func showAction(completion: AnimationsCompletion? = nil) {
		setupBeforeDisplayingState(with: config)
		
		let animations: AnimationsAction = showAnimationAction(for: config)
		
		UIView.animate(
			with: showAnimation.animator,
			animations: animations,
			completion: completion
		)
	}
	
	func hideAction(completion: AnimationsCompletion? = nil) {
		let animations: AnimationsAction = hideAnimationAction(for: config)
		
		UIView.animate(
			with: hideAnimation.animator,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Private
private extension CxjToastPresenter.ToastAnimator {
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
