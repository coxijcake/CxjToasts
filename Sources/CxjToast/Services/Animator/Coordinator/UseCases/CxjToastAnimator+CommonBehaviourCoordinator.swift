//
//  CxjToastAnimator+CommonBehaviourCoordinator.swift
//
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
	@MainActor
	final class CommonBehaviourCoordinator: Coordinator {
        //MARK: - Props
        private let toastView: ToastView
		private let sourceBackground: SourceBackground?
		private let toastLayoutCalculator: ToastLayoutCalculator
		private let sourceBackgroundLayoutCalculator: SourceBackgroundLayoutCalculator
		
        private(set) lazy var dismissedStateYTranslation: CGFloat = {
			toastLayoutCalculator
				.propertiesFor(progress: .max)
				.translation.y
        }()
        
        private(set) lazy var dismissedStateTranslation: CGPoint = {
            toastLayoutCalculator
                .propertiesFor(progress: .max)
                .translation
                .cgPoint
        }()
		
		private var transitionAnimationDimmedView: UIView?
        
        //MARK: - Lifecycle
        init(
            toastView: ToastView,
			sourceBackground: SourceBackground?,
			toastLayoutCalculator: ToastLayoutCalculator,
			sourceBackgroundLayoutCalculator: SourceBackgroundLayoutCalculator
        ) {
            self.toastView = toastView
			self.sourceBackground = sourceBackground
			self.toastLayoutCalculator = toastLayoutCalculator
			self.sourceBackgroundLayoutCalculator = sourceBackgroundLayoutCalculator
        }
        
		//MARK: - Public methods
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			addDimmedViewIfNeeded()
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			updateToastWith(animatingPropsValues: toastLayoutCalculator.presentedStateProps)
			updateSourceBackgroundWith(animatingProps: sourceBackgroundLayoutCalculator.presentedStateProps)
		}
		
        func dismissLayout(progress: ToastLayoutProgress) {
			let toastProps: ToastAnimatingProperties = toastLayoutCalculator
				.propertiesFor(progress: progress)
			let sourceBackgroundProps: SourceBackgroundAnimatingProperties = sourceBackgroundLayoutCalculator
				.propertiesFor(progress: progress)
            
            updateToastWith(animatingPropsValues: toastProps)
			updateSourceBackgroundWith(animatingProps: sourceBackgroundProps)
        }
        
        //MARK: - Private Methods
		private func addDimmedViewIfNeeded() {
			switch toastLayoutCalculator.dismissedStateProps.shadowOverlay {
			case .off:
				switch toastLayoutCalculator.presentedStateProps.shadowOverlay {
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
		
        private final func updateToastWith(animatingPropsValues: ToastAnimatingProperties) {
            let transform: CGAffineTransform = transformFor(changingValues: animatingPropsValues)
            
            toastView.transform = transform
			toastView.alpha = animatingPropsValues.alpha.value
			toastView.layer.cornerRadius = animatingPropsValues.cornerRadius.value
			
			updateDimmedViewWith(animatingProperties: animatingPropsValues)
        }
		
		private func updateSourceBackgroundWith(animatingProps: SourceBackgroundAnimatingProperties) {
			sourceBackground?.alpha = animatingProps.alpha.value
		}
		
		private func updateDimmedViewWith(animatingProperties: ToastAnimatingProperties) {
			switch animatingProperties.shadowOverlay {
			case .off:
				transitionAnimationDimmedView?.alpha = .zero
			case .on(_, let alpha):
				transitionAnimationDimmedView?.alpha = alpha.value
			}
			
			transitionAnimationDimmedView?.layer.cornerRadius = animatingProperties.cornerRadius.value
		}
        
        private func transformFor(changingValues: ToastAnimatingProperties) -> CGAffineTransform {
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
