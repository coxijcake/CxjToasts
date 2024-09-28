//
//  CxjToastAnimator+CommonBehaviourCoordinator.swift
//
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class CommonBehaviourCoordinator: Coordinator {
        //MARK: - Props
        private let toastView: ToastView
		private let animationConfigStrategy: ConfigStrategy
        private let presentedStateAnimatingProperties: AnimatingProperties
        		
		private lazy var dismissedStateAnimatingProps = animationConfigStrategy
			.dismissedStateAnimatingProperties()
		
		private lazy var layoutCalculator: LayoutCalculator = LayoutCalculator(
			presentedStateProps: presentedStateAnimatingProperties,
			dismissedStateProps: dismissedStateAnimatingProps,
			toastSize: toastView.bounds.size
		)
		
        private(set) lazy var dismissedStateYTranslation: CGFloat = {
			layoutCalculator
				.properties(for: CxjToastAnimator.LayoutCalculator.Progress(value: 1.0))
				.translationY
        }()
		
		private var transitionAnimationDimmedView: UIView?
		
		private var shouldAddDimmedView: Bool {
			dismissedStateAnimatingProps.shadowIntensity != .zero
		}
        
        //MARK: - Lifecycle
        init(
            toastView: ToastView,
			presentedStateAnimatingProperties: AnimatingProperties,
			animationConfigStrategy: ConfigStrategy
        ) {
            self.toastView = toastView
			self.presentedStateAnimatingProperties = presentedStateAnimatingProperties
			self.animationConfigStrategy = animationConfigStrategy
        }
        
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			shouldAddDimmedView
			? addTransitionDimmedView(dimColor: .black)
			: ()
			
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			updateToastWith(animatingPropsValues: presentedStateAnimatingProperties)
		}
		
        func dismissLayout(progress: ToastLayoutProgress) {
			let properties: AnimatingProperties = layoutCalculator.properties(for: progress)
            
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
