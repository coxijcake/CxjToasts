//
//  CxjToastAnimator+AnimationCoordinator.swift
//  
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class CommonBehaviourCoordinator: Coordinator {
        //MARK: - Props
        let toastView: ToastView
		let animationConfigStrategy: ConfigStrategy
        let initialAnimatingProperties: AnimatingProperties
        
        private(set) var transitionAnimationDimmedView: UIView?
		
		private lazy var dismissedStateAnimatingProps = animationConfigStrategy.dismissedStateAnimatingProperties()
		
        var dismissedStateYTranslation: CGFloat {
            dismissLayoutCalculatedProperties(for: .init(value: 1.0)).translationY
        }
        
        //MARK: - Lifecycle
        init(
            toastView: ToastView,
			initialAnimatingProperties: AnimatingProperties,
			animationConfigStrategy: ConfigStrategy
        ) {
            self.toastView = toastView
			self.initialAnimatingProperties = initialAnimatingProperties
			self.animationConfigStrategy = animationConfigStrategy
        }
		
		var shouldAddDimmedView: Bool {
			dismissedStateAnimatingProps.shadowIntensity != .zero
		}
        
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			shouldAddDimmedView ? addTransitionDimmedView(dimColor: .black) : ()
			
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			updateToastWith(animatingPropsValues: initialAnimatingProperties)
		}
		
        func dismissLayout(progress: ToastLayoutProgress) {
            let properties: AnimatingProperties = dismissLayoutCalculatedProperties(
                for: progress
            )
            
            updateToastWith(animatingPropsValues: properties)
        }
        
        //MARK: - Private Methods
		private func addTransitionDimmedView(dimColor: UIColor) {
			let view: UIView = .init(frame: toastView.bounds)
			view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			view.isUserInteractionEnabled = false
			view.backgroundColor = dimColor
			view.alpha = 1.0
			
			toastView.addSubview(view)
			self.transitionAnimationDimmedView = view
		}
		
		private func dismissLayoutCalculatedProperties(
			for progress: ToastLayoutProgress
		) -> AnimatingProperties {
			let calculator: LayoutCalculator = LayoutCalculator(
				initialStateProps: initialAnimatingProperties,
				dismissedStateProps: dismissedStateAnimatingProps,
				toastSize: toastView.bounds.size
			)
			
			return calculator.properties(for: progress)
		}
		
        private final func updateToastWith(animatingPropsValues: AnimatingProperties) {
            let transform: CGAffineTransform = transformFor(changingValues: animatingPropsValues)
            
            toastView.transform = transform
            toastView.alpha = animatingPropsValues.alpha
            toastView.layer.cornerRadius = animatingPropsValues.cornerRadius
            
            transitionAnimationDimmedView?.alpha = animatingPropsValues.shadowIntensity
            transitionAnimationDimmedView?.layer.cornerRadius = animatingPropsValues.cornerRadius
        }
        
        private func transformFor(changingValues: AnimatingProperties) -> CGAffineTransform {
            let transform: CGAffineTransform = CGAffineTransform(
                scaleX: changingValues.scale.x,
                y: changingValues.scale.y
            ).concatenating(
                CGAffineTransform(
                    translationX: .zero,
                    y: changingValues.translationY
                )
            )
            
            return transform
        }
    }
}
