//
//  CxjToastAnimator+BaseLayoutUC.swift
//  
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
    class BaseLayoutUseCase {
        let toastView: ToastView
        let config: ToastConfig
        let toastViewDefaultValues: ToastViewDefaultValues
        
        private(set) var transitionAnimationDimmedView: UIView?
        
        init(
            toastView: ToastView,
            config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues
        ) {
            self.toastView = toastView
            self.config = config
            self.toastViewDefaultValues = toastViewDefaultValues
        }
        
        final func setDefaultToastViewValues() {
            toastView.transform = toastViewDefaultValues.transform
            toastView.alpha = toastViewDefaultValues.alpha
            toastView.layer.cornerRadius = toastViewDefaultValues.cornerRadius
            transitionAnimationDimmedView?.alpha = .zero
        }
        
        final func addTransitionDimmedView() {
            let view: UIView = .init(frame: toastView.bounds)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = false
            view.backgroundColor = .clear
            view.alpha = 1.0
            
            toastView.addSubview(view)
            self.transitionAnimationDimmedView = view
        }
    }
}
