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
		prepareForShowing(with: config)
		
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
	
	func prepareForShowing(with config: ToastConfig) {
		switch config.animations.present.type {
		case .default:
			toastView.transform = .init(translationX: .zero, y: -200)
		}
	}
	
	func showAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			switch config.animations.present.type {
			case .default:
				toastView.transform = .identity
			}
		}
		
		return animations
	}
	
	func hideAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			switch config.animations.dismiss.type {
			case .default:
				toastView.transform = CGAffineTransform(translationX: .zero, y: -300)
					.concatenating(CGAffineTransform(scaleX: 0.75, y: 0.75))
			}
		}
		
		return animations
	}
}
