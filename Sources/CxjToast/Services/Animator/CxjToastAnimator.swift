//
//  CxjToastAnimator.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastAnimator {
	typealias Coordinator = CxjToastAnimationCoordinator
    typealias ToastView = CxjToastView
	typealias SourceBackground = CxjToastSourceBackground
    typealias ToastConfig = CxjToastConfiguration
	typealias Placement = ToastConfig.Layout.Placement
    typealias Animations = ToastConfig.Animation
	typealias AnimationBehaviour = Animations.Behaviour
    typealias AnimationsAction = CxjAnimation.Animations
    typealias AnimationsCompletion = CxjAnimation.Completion
	typealias ConfigAnimation = ToastConfig.Animation
	
	struct LayoutData {
		struct ToastView {
			let size: CGSize
		}
		
		struct SoureView {
			let frame: CGRect
			let safeAreaInsets: UIEdgeInsets
		}
		
		let toastView: ToastView
		let sourceView: SoureView
	}
}

@MainActor
final class CxjToastAnimator {
	//MARK: - Props
	private let toastView: ToastView
	private let sourceView: UIView
	private let sourceBackground: SourceBackground?
	private let config: ToastConfig
	
	private var presentCoordinator: Coordinator?
	private var dismissCoordinator: Coordinator?
	
	init(
		toastView: ToastView,
		sourceView: UIView,
		sourceBackground: SourceBackground?,
		config: ToastConfig
	) {
		self.toastView = toastView
		self.sourceView = sourceView
		self.sourceBackground = sourceBackground
		self.config = config
	}
}

//MARK: - Present Animator
extension CxjToastAnimator: CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation {
		config.animations.present.animation
    }
    
	func presentAction(animated: Bool, completion: AnimationsCompletion?) {
		setupCoordinators()
		
		guard let presentCoordinator else {
			completion?(false)
			return
		}
		
		let fullProgress: ToastLayoutProgress = ToastLayoutProgress.max
        
		presentCoordinator.beforeDisplayingLayout(progress: fullProgress)
		
		let animations: AnimationsAction = {
			presentCoordinator.presentingLayout()
		}
		
		UIView.animate(
			with: animated ? presentAnimation : .noAnimation,
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
    
    var dismissedStateTranslation: CGPoint {
        dismissCoordinator?.dismissedStateTranslation ?? .zero
    }
	
	func dismissAction(
		progress: CGFloat,
		animated: Bool,
		completion: AnimationsCompletion?
	) {
		let progress: ToastLayoutProgress = ToastLayoutProgress(value: progress)
		let animations: AnimationsAction = {
			self.dismissCoordinator?.dismissLayout(progress: progress)
		}
		
		UIView.animate(
			with: animated ? dismissAnimation : .noAnimation,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Coordinators configuration
private extension CxjToastAnimator {
	func setupCoordinators() {
		presentCoordinator = coordinatorFor(animation: config.animations.present)
		dismissCoordinator = coordinatorFor(animation: config.animations.dismiss)
	}
	
	func coordinatorFor(animation: ToastConfig.Animation) -> Coordinator {
		CoordinatorConfigurator.coordinator(
			forToastView: toastView,
			sourceBackground: sourceBackground,
			animation: animation,
			layoutData: .init(
				toastView: .init(size: toastView.bounds.size),
				sourceView: .init(frame: sourceView.frame, safeAreaInsets: sourceView.safeAreaInsets)
			),
			placement: config.layout.placement
		)
	}
}
