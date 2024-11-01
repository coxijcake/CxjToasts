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
	typealias SourceBackground = CxjToastSourceBackground
    typealias ToastConfig = CxjToastConfiguration
	typealias Placement = ToastConfig.Layout.Placement
    typealias Animations = ToastConfig.Animations
	typealias AnimationBehaviour = Animations.Behaviour
    typealias AnimationsAction = CxjAnimation.Animations
    typealias AnimationsCompletion = CxjAnimation.Completion
}

final class CxjToastAnimator {
	//MARK: - Props
	private let toastView: ToastView
	private let sourceBackground: SourceBackground?
	private let config: ToastConfig
	
	private lazy var coordinator: Coordinator = CoordinatorConfigurator.coordinator(
		forToastView: toastView,
		sourceBackground: sourceBackground,
		with: config
	)
	
	init(
		toastView: ToastView,
		sourceBackground: SourceBackground?,
		config: ToastConfig
	) {
        self.toastView = toastView
		self.sourceBackground = sourceBackground
        self.config = config
    }
}

//MARK: - Present Animator
extension CxjToastAnimator: CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation {
        config.animations.present
    }
    
	func presentAction(completion: AnimationsCompletion?) {
		let fullProgress: ToastLayoutProgress = ToastLayoutProgress.max
        
		coordinator.beforeDisplayingLayout(progress: fullProgress)
		
		let animations: AnimationsAction = {
			self.coordinator.presentingLayout()
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
    
    var dismissedStateYTranslation: CGFloat {
		coordinator.dismissedStateYTranslation
    }
	
	func dismissAction(
		progress: CGFloat,
		animated: Bool,
		completion: AnimationsCompletion?
	) {
		let progress: ToastLayoutProgress = ToastLayoutProgress(value: progress)
		let animations: AnimationsAction = {
			self.coordinator.dismissLayout(progress: progress)
		}
		
		UIView.animate(
			with: animated ? dismissAnimation : .noAnimation,
			animations: animations,
			completion: completion
		)
	}
}
