//
//  CxjToastAnimator+BottomrLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class BottomLayoutUseCase: BaseLayoutUseCase, LayoutUseCase {
		let verticalOffset: CGFloat
        
        override var dismissedStateDefaultAnimatingProps: AnimatingProperties {
            AnimatingProperties(
				alpha: .zero,
				scale: .initial,
                translationY: dismissedTranslationY(),
                cornerRadius: .zero,
                shadowIntensity: .zero
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
		
		func presentingLayout() {
			setDefaultToastViewValues()
		}
        
        private func dismissedTranslationY() -> CGFloat {
            let sourceView = config.sourceView
            let translationY: CGFloat =
            verticalOffset
            + sourceView.safeAreaInsets.bottom
            + toastView.bounds.size.height
            
            return translationY
        }
	}
}
