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

struct CxjToastAnimator {
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
		setupBeforeDisplayingState(with: config)
		
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
	
	func dismissAction(completion: AnimationsCompletion?) {
		let animations: AnimationsAction = dismissAnimationAction(for: config)
		
		UIView.animate(
			with: dismissAnimation,
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - Private
private extension CxjToastAnimator {	
	func setupBeforeDisplayingState(with config: ToastConfig) {
		let toastSize: CGSize = toastView.bounds.size
		
		switch config.layout.placement {
		case .top(vericalOffset: let verticalOffset):
           setupBeforeDisplayingFromTopState(verticalOffset: verticalOffset)
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
	
	func presentAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
            toastView.transform = initialValues.transform
            toastView.alpha = initialValues.alpha
            toastView.layer.cornerRadius = initialValues.cornerRadius
            toastView.layer.borderWidth = initialValues.borderWidth
            toastView.layer.borderColor = initialValues.borderColor
		}
		
		return animations
	}
	
	func dismissAnimationAction(for config: ToastConfig) -> AnimationsAction {
		let animations: AnimationsAction = {
			setupBeforeDisplayingState(with: config)
		}
		
		return animations
	}
    
    func setupBeforeDisplayingFromTopState(verticalOffset: CGFloat) {
        let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
        let sourceViewSafeAreaInsets: UIEdgeInsets = config.sourceView.safeAreaInsets
        
        if applicationSafeAreaInsets == sourceViewSafeAreaInsets,
           CxjDynamicIslandHelper.isDynamicIslandEnabled {
            setupBeforeDisplayingFromTopDynamicIsnandState(verticalOffset: verticalOffset)
        } else {
            let sourceViewOffset: CGFloat = verticalOffset + config.sourceView.safeAreaInsets.top
            let translationY: CGFloat = toastView.bounds.size.height + sourceViewOffset
            toastView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                .concatenating(CGAffineTransform(translationX: .zero, y: -translationY))
        }
    }
    
    func setupBeforeDisplayingFromTopDynamicIsnandState(verticalOffset: CGFloat) {
        let toastSize: CGSize = toastView.bounds.size
        let islandWidth: CGFloat = CxjDynamicIslandHelper.minWidth
        let islandHeight: CGFloat = CxjDynamicIslandHelper.estimatedMinHeight
        
        let xScale: CGFloat = min(islandWidth, toastSize.width) / max(islandWidth, toastSize.width)
        let yScale: CGFloat = min(islandHeight, toastSize.height) / max(islandHeight, toastSize.height)
        
        
        let yTranslation: CGFloat = config.sourceView.safeAreaInsets.top
        + toastView.bounds.size.height
        + verticalOffset
        - CxjDynamicIslandHelper.topOffset
        - CxjDynamicIslandHelper.estimatedMinHeight
        
        toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
            .concatenating(CGAffineTransform(translationX: .zero, y: -yTranslation))
        toastView.layer.cornerRadius = CxjDynamicIslandHelper.cornerRadius
        toastView.layer.borderColor = CxjDynamicIslandHelper.backgroundColor.cgColor
        toastView.layer.borderWidth = 4
    }
}
