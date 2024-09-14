//
//  TopPlacementDefaultLayoutUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopPlacementDefaultLayoutUseCase: TopPlacementAnimatorLayoutUseCase {
		let toastView: ToastView
        let config: ToastConfig
		let toastViewDefaultValues: ToastViewDefaultValues
		let verticalOffset: CGFloat
		
		init(
			toastView: ToastView,
            config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) {
			self.toastView = toastView
            self.config = config
			self.toastViewDefaultValues = toastViewDefaultValues
			self.verticalOffset = verticalOffset
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			toastView.transform = toastViewDefaultValues.transform
		}
        
        func dismissLayout(progress: ToastLayoutProgress) {
            let changingValues: AnimationChangingValues = changingValues(
                for: config.animations.changes,
                initial: AnimationChangingValues(
                    alpha: 1.0,
                    scale: .init(x: 1.0, y: 1.0),
                    translationY: .zero
                ),
                progress: progress
            )
            
            let transform: CGAffineTransform = CGAffineTransform(
                scaleX: changingValues.scale.x,
                y: changingValues.scale.y
            ).concatenating(
                CGAffineTransform(
                    translationX: .zero,
                    y: changingValues.translationY
                )
            )
            
            toastView.transform = transform
            toastView.alpha = changingValues.alpha
        }
        
        private func fullScale(for changes: Set<AnimationsChanges>, initialScale: CGFloat) -> CGFloat {
            guard changes.contains(.scale) else { return initialScale }
            
            return 0.5
        }
        
        private func changingValues(
            for changes: Set<AnimationsChanges>,
            initial: AnimationChangingValues,
            progress: ToastLayoutProgress
        ) -> AnimationChangingValues {
            let alpha: CGFloat = changes.contains(.alpha) ? 0.0 : initial.alpha
            let scale: AnimationChangingValues.Scale = changes.contains(.scale) ? .init(x: 0.5, y: 0.5) : initial.scale
            let translationY: CGFloat = changes.contains(.translation) ? translationY(for: progress) : initial.translationY
            
            return AnimationChangingValues(
                alpha: alpha,
                scale: scale,
                translationY: translationY
            )
        }
        
        private func translationY(for progress: ToastLayoutProgress) -> CGFloat {
            let sourceView = config.sourceView
            let sourceViewOffset: CGFloat = verticalOffset + sourceView.safeAreaInsets.top
            let fullTranslationY: CGFloat = toastView.bounds.size.height + sourceViewOffset
            let translationY: CGFloat = -fullTranslationY * progress.value
            
            return translationY
        }
	}
}
