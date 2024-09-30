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
				.propertiesFor(progress: .max)
				.translation.y
        }()
		
		private var transitionAnimationDimmedView: UIView?
        
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
			let properties: AnimatingProperties = layoutCalculator.propertiesFor(progress: progress)
            
            updateToastWith(animatingPropsValues: properties)
        }
        
        //MARK: - Private Methods
		private func addDimmedViewIfNeeded() {
			switch dismissedStateAnimatingProps.shadow {
			case .off:
				switch presentedStateAnimatingProperties.shadow {
				case .off: return
				case .on(let color, _):
					addTransitionDimmedView(dimColor: color, cornersMask: toastView.layer.maskedCorners)
				}
			case .on(let color, _):
				addTransitionDimmedView(dimColor: color, cornersMask: toastView.layer.maskedCorners)
			}
		}
		
		private func addTransitionDimmedView(dimColor: UIColor, cornersMask: CACornerMask) {
			let view: UIView = .init(frame: toastView.bounds)
			view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
			view.isUserInteractionEnabled = false
			view.backgroundColor = dimColor
			view.alpha = .zero
			view.layer.maskedCorners = cornersMask
			
			toastView.addSubview(view)
			self.transitionAnimationDimmedView = view
		}
		
        private final func updateToastWith(animatingPropsValues: AnimatingProperties) {
            let transform: CGAffineTransform = transformFor(changingValues: animatingPropsValues)
            
            toastView.transform = transform
			toastView.alpha = animatingPropsValues.alpha.value
			toastView.layer.cornerRadius = animatingPropsValues.cornerRadius.value
            
			updateDimmedViewWith(animatingProperties: animatingPropsValues)
        }
		
		private func updateDimmedViewWith(animatingProperties: AnimatingProperties) {
			switch animatingProperties.shadow {
			case .off:
				transitionAnimationDimmedView?.alpha = .zero
			case .on(_, let alpha):
				transitionAnimationDimmedView?.alpha = alpha.value
			}
			
			transitionAnimationDimmedView?.layer.cornerRadius = animatingProperties.cornerRadius.value
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
