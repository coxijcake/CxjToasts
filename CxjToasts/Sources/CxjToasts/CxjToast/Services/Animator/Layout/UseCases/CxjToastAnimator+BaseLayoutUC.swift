//
//  CxjToastAnimator+BaseLayoutUC.swift
//  
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
    class BaseLayoutUseCase {
        //MARK: - Props
        let toastView: ToastView
        let config: ToastConfig
        let initialAnimatingProperties: AnimatingProperties
        
        private(set) var transitionAnimationDimmedView: UIView?
		
		private lazy var dismissedStateAnimatingProps: AnimatingProperties = {
			switch config.animations.behaviour {
			case .default:
				dismissedStateDefaultAnimatingProps
			case .custom(let changes):
				dismissedAnimatingCustomProps(
					for: changes,
					initialProps: initialAnimatingProperties
				)
			}
		}()
        
        //MARK: - Props to override
		var dismissedStateDefaultAnimatingProps: AnimatingProperties {
			initialAnimatingProperties
		}
		
        var dismissedStateYTranslation: CGFloat {
            dismissLayoutCalculatedProperties(for: .init(value: 1.0)).translationY
        }
        
        //MARK: - Lifecycle
        init(
            toastView: ToastView,
            config: ToastConfig
        ) {
            self.toastView = toastView
            self.config = config
            self.initialAnimatingProperties = AnimatingProperties(
                alpha: toastView.alpha,
                scale: .initial,
                translationY: .zero,
                cornerRadius: toastView.layer.cornerRadius,
                shadowIntensity: .zero
            )
        }
		
		var shouldAddDimmedView: Bool {
			switch config.animations.behaviour {
			case .default: 
				return false
			case .custom(let changes):
				for change in changes {
					switch change {
					case .shadow(intensity: _): return true
					default: continue
					}
				}
				
				return false
			}
		}
        
        //MARK: - No final methods
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			shouldAddDimmedView ? addTransitionDimmedView(dimColor: .black) : ()
			
			dismissLayout(progress: progress)
		}
		
        func dismissLayout(progress: ToastLayoutProgress) {
            let properties: AnimatingProperties = dismissLayoutCalculatedProperties(
                for: progress
            )
            
            updateToastWith(animatingPropsValues: properties)
        }
        
        //MARK: - Final methods
        final func setDefaultToastViewValues() {
            updateToastWith(animatingPropsValues: initialAnimatingProperties)
        }
        
        final func addTransitionDimmedView(dimColor: UIColor) {
            let view: UIView = .init(frame: toastView.bounds)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = false
            view.backgroundColor = dimColor
            view.alpha = 1.0
            
            toastView.addSubview(view)
            self.transitionAnimationDimmedView = view
        }
        
        final func dismissLayoutCalculatedProperties(
            for progress: ToastLayoutProgress
        ) -> AnimatingProperties {
            let calculator: LayoutCalculator = LayoutCalculator(
                initialStateProps: initialAnimatingProperties,
                dismissedStateProps: dismissedStateAnimatingProps,
                toastSize: toastView.bounds.size
            )
            
            return calculator.properties(for: progress)
        }
        
        //MARK: - Private Methods
		private func dismissedAnimatingCustomProps(
			for changes: Set<CxjToastConfiguration.Animations.Behaviour.CustomBehaviourChange>,
			initialProps: AnimatingProperties
		) -> AnimatingProperties {
			let resultAnimatingProperties: AnimatingProperties = initialProps.changing { props in
				for change in changes {
					switch change {
					case .scale(let value):
						props.scale = .init(x: value.x, y: value.y)
					case .translation(let value):
						props.translationY = value.y
					case .alpha(let intensity):
						props.alpha = intensity
					case .shadow(let intensity):
						props.shadowIntensity = intensity
					case .corners(let radius):
						props.cornerRadius = radius
					}
				}
			}
			
			return resultAnimatingProperties
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
