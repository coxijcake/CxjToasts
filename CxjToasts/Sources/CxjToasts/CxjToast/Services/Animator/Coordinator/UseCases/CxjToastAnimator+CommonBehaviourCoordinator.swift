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
				.translation.y
        }()
		
		private var transitionAnimationDimmedView: UIView?
		
		private var shouldAddDimmedView: Bool {
			dismissedStateAnimatingProps.shadowIntensity.value != .zero
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
			addDimmedViewIfNeeded()
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
		private func addDimmedViewIfNeeded() {
			guard dismissedStateAnimatingProps.shadowIntensity.value != .zero else { return }
			
			addTransitionDimmedView(dimColor: .black, cornersMask: toastView.layer.maskedCorners)
		}
		
		private func addTransitionDimmedView(dimColor: UIColor, cornersMask: CACornerMask) {
			let view: UIView = .init(frame: toastView.bounds)
			view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			view.isUserInteractionEnabled = false
			view.backgroundColor = dimColor
			view.alpha = 1.0
			view.layer.maskedCorners = cornersMask
			
			toastView.addSubview(view)
			self.transitionAnimationDimmedView = view
		}
		
        private final func updateToastWith(animatingPropsValues: AnimatingProperties) {
            let transform: CGAffineTransform = transformFor(changingValues: animatingPropsValues)
            
            toastView.transform = transform
			toastView.alpha = animatingPropsValues.alpha.value
			toastView.layer.cornerRadius = animatingPropsValues.cornerRadius.value
            
			transitionAnimationDimmedView?.alpha = animatingPropsValues.shadowIntensity.value
			transitionAnimationDimmedView?.layer.cornerRadius = animatingPropsValues.cornerRadius.value
        }
        
        private func transformFor(changingValues: AnimatingProperties) -> CGAffineTransform {
			let transform: CGAffineTransform = CGAffineTransform(
				scaleX: changingValues.scale.x,
				y: changingValues.scale.y
			).concatenating(
				CGAffineTransform(
					translationX: changingValues.translation.x,
					y: changingValues.translation.y
				)
            )
            
            return transform
        }
    }
}
