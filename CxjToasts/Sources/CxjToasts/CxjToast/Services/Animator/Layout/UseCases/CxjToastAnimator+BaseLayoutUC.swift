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
        
        //MARK: - Props to override
        var dismissedStateAnimatingProps: AnimatingProperties {
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
        
        //MARK: - No final methods
        func dismissLayout(progress: ToastLayoutProgress) {
            let calculator: LayoutCalculator = LayoutCalculator(
                initialStateProps: initialAnimatingProperties,
                dismissedStateProps: dismissedStateAnimatingProps,
                toastSize: toastView.bounds.size
            )
            
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
