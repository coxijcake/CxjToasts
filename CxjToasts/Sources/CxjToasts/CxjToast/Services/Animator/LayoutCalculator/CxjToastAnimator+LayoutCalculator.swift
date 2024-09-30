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
		typealias Translation = AnimatingProperties.Translation
		typealias CornerRadius = AnimatingProperties.CornerRadius
		typealias Shadow = AnimatingProperties.Shadow
		
        let presentedStateProps: AnimatingProperties
        let dismissedStateProps: AnimatingProperties
        
        let toastSize: CGSize
        
		//MARK: - Public API
        func propertiesFor(progress: Progress) -> AnimatingProperties {
			let alpha: CGFloat = alphaFor(progress: progress)
			let scale: Scale = scaleFor(progress: progress)
			let translation: Translation = translationFor(progress: progress, scale: scale)
			let cornerRadius: CornerRadius = cornerRadiusFor(progress: progress)
			let shadow: Shadow = shadowFor(progress: progress)
            
            return AnimatingProperties(
				alpha: .init(value: alpha),
                scale: scale,
                translation: translation,
                cornerRadius: cornerRadius,
				shadow: shadow
            )
        }
		
		//MARK: - Private
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
		
		private func scaleFor(progress: Progress) -> Scale {
			let initialScale: AnimatingProperties.Scale = presentedStateProps.scale
			
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
		
		private func cornerRadiusFor(progress: Progress) -> CornerRadius {
			let initialCornerRadius: CGFloat = presentedStateProps.cornerRadius.value
			
			let finalCornerRadius: CGFloat = dismissedStateProps.cornerRadius.value
			let calculatedCornerRadius: CGFloat =
			finalCornerRadius
			* progress.value
			+ initialCornerRadius
			* progress.revertedValue
			
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
		
		private func shadowFor(progress: Progress) -> Shadow {
			let initialShadowAlpha: CGFloat = {
				switch presentedStateProps.shadow {
				case .off: ClampedAlpha.min.value
				case .on(_, alpha: let alpha): alpha.value
				}
			}()
			
			switch dismissedStateProps.shadow {
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
