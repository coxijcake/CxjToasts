//
//  CxjToastAnimator+TopDefaultLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopDefaultLayoutUseCase: BaseLayoutUseCase, TopLayoutUseCase {
		let verticalOffset: CGFloat
        
        override var dismissedStateAnimatingProps: AnimatingProperties {
            AnimatingProperties(
                alpha: 1.0,
                scale: .initial,
                translationY: dismissedTranslationY(),
                cornerRadius: 0,
                shadowIntensity: 0
            )
        }
		
		init(
			toastView: ToastView,
            config: ToastConfig,
			verticalOffset: CGFloat
		) {
			self.verticalOffset = verticalOffset
            super.init(
                toastView: toastView,
                config: config
            )
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
            setDefaultToastViewValues()
		}
        
        private func dismissedTranslationY() -> CGFloat {
            let sourceView = config.sourceView
            let sourceViewOffset: CGFloat =
            verticalOffset
            + sourceView.safeAreaInsets.top
            
            let fullTranslationY: CGFloat =
            toastView.bounds.size.height
            + sourceViewOffset
            
            return -fullTranslationY
        }
	}
}
