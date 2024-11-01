//
//  CxjToastAnimator+LayoutCalculator.swift
//
//
//  Created by Nikita Begletskiy on 16/09/2024.
//

import UIKit


extension CxjToastAnimator {
    struct ToastLayoutCalculator {
		//MARK: - Types
		typealias Properties = ToastAnimatingProperties
		typealias Progress = ToastLayoutProgress
		typealias Scale = ToastAnimatingProperties.Scale
		typealias Translation = ToastAnimatingProperties.Translation
		typealias CornerRadius = ToastAnimatingProperties.CornerRadius
		typealias ShadowOverlay = ToastAnimatingProperties.ShadowOverlay
		
		//MARK: - Props
        let presentedStateProps: ToastAnimatingProperties
        let dismissedStateProps: ToastAnimatingProperties
        
        let toastSize: CGSize
        
		//MARK: - Toast properties
        func propertiesFor(progress: Progress) -> ToastAnimatingProperties {
			let alpha: CGFloat = alphaFor(progress: progress)
			let scale: Scale = scaleFor(progress: progress)
			let translation: Translation = translationFor(progress: progress, scale: scale)
			let cornerRadius: CornerRadius = cornerRadiusFor(progress: progress)
			let shadow: ShadowOverlay = shadowOverlayFor(progress: progress)
            
            return ToastAnimatingProperties(
				alpha: .init(value: alpha),
                scale: scale,
                translation: translation,
                cornerRadius: cornerRadius,
				shadowOverlay: shadow
            )
        }
		
		//MARK: - Alpha
		private func alphaFor(progress: Progress) -> CGFloat {
			let initialAlpha: CGFloat = presentedStateProps.alpha.value
			
			let finalAlpha: CGFloat = dismissedStateProps.alpha.value
			let alpha: CGFloat = 
			finalAlpha
			* progress.value
			+ initialAlpha 
			* progress.revertedValue
			
			return alpha
		}
		
		//MARK: - Scale
		private func scaleFor(progress: Progress) -> Scale {
			let initialScale: ToastAnimatingProperties.Scale = presentedStateProps.scale
			
			let scaleX: CGFloat =
			dismissedStateProps.scale.x
			* progress.value
			+ presentedStateProps.scale.x
			* progress.revertedValue
			
			let scaleY: CGFloat =
			dismissedStateProps.scale.y
			* progress.value
			+ presentedStateProps.scale.y
			* progress.revertedValue
			
			let scale: Scale = Scale(
				x: scaleX,
				y: scaleY
			)
			
			return scale
		}
		
		//MARK: - Translation
		private func translationFor(progress: Progress, scale: Scale) -> Translation {
			let xTranslation: CGFloat = xTranslationFor(progress: progress, scale: scale)
			let yTranslation: CGFloat = yTranslationFor(progress: progress, scale: scale)
			
			return Translation(x: xTranslation, y: yTranslation)
		}
		
		private func xTranslationFor(progress: Progress, scale: Scale) -> CGFloat {
			let initialTranslation: CGFloat = presentedStateProps.translation.x
			
			let xTranslation: CGFloat =
			dismissedStateProps.translation.x
			* progress.value
			
			return xTranslation
		}
		
		private func yTranslationFor(progress: Progress, scale: Scale) -> CGFloat {
			let initialTranslation: CGFloat = presentedStateProps.translation.y
			
			let toastScaledSizeDifference: CGFloat =
			((toastSize.height - (toastSize.height * scale.y)) / 2)
			
			let yTranslation: CGFloat =
			dismissedStateProps.translation.y
			* progress.value
			- toastScaledSizeDifference
			
			return yTranslation
		}
		
		//MARK: - Corner Radius
		private func cornerRadiusFor(progress: Progress) -> CornerRadius {
			let smoothedProgress: Progress = progress.smoothed(threshold: 0.3)
			
			let initialCornerRadius: CGFloat = presentedStateProps.cornerRadius.value
			
			let finalCornerRadius: CGFloat = dismissedStateProps.cornerRadius.value
			let calculatedCornerRadius: CGFloat =
			finalCornerRadius
			* smoothedProgress.value
			+ initialCornerRadius
			* smoothedProgress.revertedValue
			
			let constraint: CornerRadius.Constraint = dismissedStateProps.cornerRadius.constraint
			
			let safeCornerRadius: CGFloat = {
				switch constraint {
				case .none:
					return calculatedCornerRadius
				case .halfHeight:
					let maxCornerRadius: CGFloat = toastSize.height * 0.5
					return min(maxCornerRadius, calculatedCornerRadius)
				}
			}()
			
			return .init(
				value: safeCornerRadius,
				constraint: constraint
			)
		}
		
		//MARK: - Shadow Overlay
		private func shadowOverlayFor(progress: Progress) -> ShadowOverlay {
			let initialShadowAlpha: CGFloat = {
				switch presentedStateProps.shadowOverlay {
				case .off: ClampedAlpha.min.value
				case .on(_, alpha: let alpha): alpha.value
				}
			}()
			
			switch dismissedStateProps.shadowOverlay {
			case .off: 
				return .off
			case .on(let color, alpha: let alpha):
				let finalShadowAlpha: CGFloat = alpha.value
				let progressShadowAlpha: CGFloat =
				finalShadowAlpha
				* progress.value
				+ initialShadowAlpha
				* progress.revertedValue
				
				return .on(color: color, alpha: .init(value: progressShadowAlpha))
			}
		}
    }
}

extension CxjToastAnimator {
	struct SourceBackgroundCalculator {
		typealias Properties = SourceBackgroundAnimatingProperties
		typealias Progress = ToastLayoutProgress
		
		//MARK: - Props
		let presentedStateProps: Properties
		let dismissedStateProps: Properties
		
		func propertiesFor(progress: Progress) -> Properties {
			let alpha: CGFloat = alphaValueFor(progress: progress)
			
			return Properties(
				alpha: .init(value: alpha)
			)
		}
		
		//MARK: - Alpha
		private func alphaValueFor(progress: Progress) -> CGFloat {
			let initialAlpha: CGFloat = presentedStateProps.alpha.value
			
			let finalAlpha: CGFloat = dismissedStateProps.alpha.value
			let alpha: CGFloat =
			finalAlpha
			* progress.value
			+ initialAlpha
			* progress.revertedValue
			
			return alpha
		}
	}
}
