//
//  CxjToastAnimator+LayoutCalculator.swift
//
//
//  Created by Nikita Begletskiy on 16/09/2024.
//

import UIKit


extension CxjToastAnimator {
    struct LayoutCalculator {
        let initialStateProps: AnimatingProperties
        let dismissedStateProps: AnimatingProperties
        
        let toastSize: CGSize
        
        func properties(for progress: ToastLayoutProgress) -> AnimatingProperties {
            let initialAlpha: CGFloat = initialStateProps.alpha
            let finalAlpha: CGFloat = dismissedStateProps.alpha
            let alpha: CGFloat = finalAlpha * progress.value + initialAlpha * progress.revertedValue
            
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
            
            let scale: AnimatingProperties.Scale = AnimatingProperties.Scale(
                x: scaleX,
                y: scaleY
            )
            
            let toastScaledSizeDifference: CGFloat =
            ((toastSize.height - (toastSize.height * scale.y)) / 2)
            
            let yTranslation: CGFloat =
            dismissedStateProps.translationY
            * progress.value
            - toastScaledSizeDifference
            
            let initialCornerRadius: CGFloat = initialStateProps.cornerRadius
            let finalCornerRadius: CGFloat = dismissedStateProps.cornerRadius
            let cornerRadius: CGFloat =
            finalCornerRadius
            * progress.value
            + initialCornerRadius
            * progress.revertedValue
            let safeCornerRadius: CGFloat = min(initialCornerRadius, cornerRadius)
            
            let initialShadowAlpha: CGFloat = initialStateProps.shadowIntensity
            let finalShadowAlpha: CGFloat = dismissedStateProps.shadowIntensity
            let shadowAlpha: CGFloat = finalShadowAlpha
            * progress.value
            + initialShadowAlpha
            * progress.revertedValue
            
            return AnimatingProperties(
                alpha: alpha,
                scale: scale,
                translationY: yTranslation,
                cornerRadius: safeCornerRadius,
                shadowIntensity: shadowAlpha
            )
        }
    }
}
