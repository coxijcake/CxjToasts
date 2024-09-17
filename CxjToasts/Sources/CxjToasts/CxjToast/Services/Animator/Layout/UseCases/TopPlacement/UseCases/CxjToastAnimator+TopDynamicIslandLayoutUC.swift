//
//  CxjToastAnimator+TopDynamicIslandLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopDynamicIslandLayoutUseCase: BaseLayoutUseCase, TopLayoutUseCase {
		let verticalOffset: CGFloat
        
        override var dismissedStateAnimatingProps: AnimatingProperties {
            AnimatingProperties(
                alpha: 1.0,
                scale: dissmisScale(),
                translationY: dismissYTranslation(),
                cornerRadius: CxjDynamicIslandHelper.cornerRadius,
                shadowIntensity: 1.0
            )
        }
		
		init(
			toastView: ToastView,
            config: ToastConfig,
            toastViewDefaultValues: ToastViewDefaultValues,
			verticalOffset: CGFloat
		) {
			self.verticalOffset = verticalOffset
            super.init(
                toastView: toastView,
                config: config,
                toastViewDefaultValues: toastViewDefaultValues
            )
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
            addTransitionDimmedView(dimColor: CxjDynamicIslandHelper.backgroundColor)
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
			setDefaultToastViewValues()
		}
		
        private func dissmisScale() -> AnimatingProperties.Scale {
            let toastSize: CGSize = toastView.bounds.size
            let dynamicIslandSize: CGSize = CGSize(
                width: CxjDynamicIslandHelper.minWidth,
                height: CxjDynamicIslandHelper.estimatedMinHeight
            )
            
            let xScale: CGFloat =
            min(dynamicIslandSize.width, toastSize.width)
            / max(dynamicIslandSize.width, toastSize.width)
            
            let yScale: CGFloat =
            min(dynamicIslandSize.height, toastSize.height)
            / max(dynamicIslandSize.height, toastSize.height)
            
            return .init(x: xScale, y: yScale)
        }
        
        private func dismissYTranslation() -> CGFloat {
            let yTranslation: CGFloat =
            verticalOffset
            + CxjDynamicIslandHelper.estimatedMinHeight
            + CxjDynamicIslandHelper.estimatedBottomOffset
            
            return -yTranslation
        }
        
//		override func dismissLayout(progress: ToastLayoutProgress) {
//			let toastSize: CGSize = toastView.bounds.size
//			let islandWidth: CGFloat = CxjDynamicIslandHelper.minWidth
//			let islandHeight: CGFloat = CxjDynamicIslandHelper.estimatedMinHeight
//			
//			let xScaleStart: CGFloat = min(islandWidth, toastSize.width) / max(islandWidth, toastSize.width)
//			let yScaleStart: CGFloat = min(islandHeight, toastSize.height) / max(islandHeight, toastSize.height)
//			
//			let baseScale: CGFloat = 1.0
//			let xScale: CGFloat = xScaleStart + (baseScale - xScaleStart) * progress.revertedValue
//			let yScale: CGFloat = yScaleStart + (baseScale - yScaleStart) * progress.revertedValue
//            
//            let originalHeight = toastSize.height
//            let scaledHeight = originalHeight * yScale
//			
//            let yTranslation: CGFloat =
//            verticalOffset
//            + CxjDynamicIslandHelper.estimatedMinHeight
//            + CxjDynamicIslandHelper.estimatedBottomOffset
//			
//			let interpolatedYTranslation =
//            -yTranslation
//            * progress.value
//            - ((originalHeight - scaledHeight) / 2)
//            
//			let cornerRadiusStart: CGFloat = CxjDynamicIslandHelper.cornerRadius
//			let cornerRadiusEnd: CGFloat = toastViewDefaultValues.cornerRadius
//			let interpolatedCornerRadius: CGFloat = cornerRadiusStart * progress.value + cornerRadiusEnd * progress.revertedValue
//            let safeCornerRadius: CGFloat = min(toastViewDefaultValues.cornerRadius, interpolatedCornerRadius)
//			
//			let borderAlphaStart: CGFloat = 1.0
//			let borderAlphaEnd: CGFloat = 0.0
//			let interpolatedBorderAlpha: CGFloat = borderAlphaStart * progress.value + borderAlphaEnd * progress.revertedValue
//			
//            let transitionAlphaStart: CGFloat = 1.0
//			let transitionViewAlphaEnd: CGFloat = 0.0
//			let interpolatedTransitionViewAlpha: CGFloat = transitionAlphaStart * progress.value + transitionViewAlphaEnd * progress.revertedValue
//						
//			toastView.transform = CGAffineTransform(scaleX: xScale, y: yScale)
//				.concatenating(CGAffineTransform(translationX: .zero, y: interpolatedYTranslation))
//			
//			toastView.layer.cornerRadius = safeCornerRadius
//            
//            transitionAnimationDimmedView?.backgroundColor = CxjDynamicIslandHelper.backgroundColor
//            transitionAnimationDimmedView?.alpha = interpolatedTransitionViewAlpha
//            transitionAnimationDimmedView?.layer.cornerRadius = safeCornerRadius
//		}
	}
}
