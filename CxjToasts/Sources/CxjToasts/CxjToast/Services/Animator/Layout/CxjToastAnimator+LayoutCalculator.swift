//
//  CxjToastAnimator+LayoutCalculator.swift
//
//
//  Created by Nikita Begletskiy on 16/09/2024.
//

import UIKit


extension CxjToastAnimator {
    struct LayoutCalculator {
		typealias Progress = ToastLayoutProgress
		typealias Scale = AnimatingProperties.Scale
		
        let initialStateProps: AnimatingProperties
        let dismissedStateProps: AnimatingProperties
        
        let toastSize: CGSize
        
        func properties(for progress: Progress) -> AnimatingProperties {
			let alpha: CGFloat = alpha(for: progress)
			let scale: Scale = scale(for: progress)
			let yTranslation: CGFloat = yTranslation(for: progress, scale: scale)
			let cornerRadius: CGFloat = cornerRadius(for: progress)
			let shadowAlpha: CGFloat = shadowAlpha(for: progress)
            
            return AnimatingProperties(
                alpha: alpha,
                scale: scale,
                translationY: yTranslation,
                cornerRadius: cornerRadius,
                shadowIntensity: shadowAlpha
            )
        }
		
		private func alpha(for progress: Progress) -> CGFloat {
			let initialAlpha: CGFloat = initialStateProps.alpha
			
			let finalAlpha: CGFloat = dismissedStateProps.alpha
			let alpha: CGFloat = finalAlpha * progress.value + initialAlpha * progress.revertedValue
			
			return alpha
		}
		
		private func scale(for progress: Progress) -> Scale {
			let initialScale: AnimatingProperties.Scale = initialStateProps.scale
			
			let scaleX: CGFloat =
			dismissedStateProps.scale.x
			* progress.value
			+ initialStateProps.scale.x
			* progress.revertedValue
			
			let scaleY: CGFloat =
			dismissedStateProps.scale.y
			* progress.value
			+ initialStateProps.scale.y
			* progress.revertedValue
			
			let scale: Scale = Scale(
				x: scaleX,
				y: scaleY
			)
			
			return scale
		}
		
		private func yTranslation(for progress: Progress, scale: Scale) -> CGFloat {
			let initialTranslation: CGFloat = initialStateProps.translationY
			
			let toastScaledSizeDifference: CGFloat =
			((toastSize.height - (toastSize.height * scale.y)) / 2)
			
			let yTranslation: CGFloat =
			dismissedStateProps.translationY
			* progress.value
			- toastScaledSizeDifference
			
			return yTranslation
		}
		
		private func cornerRadius(for progress: Progress) -> CGFloat {
			let initialCornerRadius: CGFloat = initialStateProps.cornerRadius
			
			let finalCornerRadius: CGFloat = dismissedStateProps.cornerRadius
			let cornerRadius: CGFloat =
			finalCornerRadius
			* progress.value
			+ initialCornerRadius
			* progress.revertedValue
			
			let safeCornerRadius: CGFloat = min(initialCornerRadius, cornerRadius)
			
			return safeCornerRadius
		}
		
		private func shadowAlpha(for progress: Progress) -> CGFloat {
			let initialShadowAlpha: CGFloat = initialStateProps.shadowIntensity
			
			let finalShadowAlpha: CGFloat = dismissedStateProps.shadowIntensity
			let shadowAlpha: CGFloat = finalShadowAlpha
			* progress.value
			+ initialShadowAlpha
			* progress.revertedValue
			
			return shadowAlpha
		}
    }
}
