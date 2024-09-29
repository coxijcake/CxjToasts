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
		
        let presentedStateProps: AnimatingProperties
        let dismissedStateProps: AnimatingProperties
        
        let toastSize: CGSize
        
		//MARK: - Public API
        func properties(for progress: Progress) -> AnimatingProperties {
			let alpha: CGFloat = alpha(for: progress)
			let scale: Scale = scale(for: progress)
			let translation: Translation = translation(for: progress, scale: scale)
			let cornerRadius: CornerRadius = cornerRadius(for: progress)
			let shadowAlpha: CGFloat = shadowAlpha(for: progress)
            
            return AnimatingProperties(
				alpha: .init(value: alpha),
                scale: scale,
                translation: translation,
                cornerRadius: cornerRadius,
				shadowIntensity: .init(value: shadowAlpha)
            )
        }
		
		//MARK: - Private
		private func alpha(for progress: Progress) -> CGFloat {
			let initialAlpha: CGFloat = presentedStateProps.alpha.value
			
			let finalAlpha: CGFloat = dismissedStateProps.alpha.value
			let alpha: CGFloat = finalAlpha * progress.value + initialAlpha * progress.revertedValue
			
			return alpha
		}
		
		private func scale(for progress: Progress) -> Scale {
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
		
		private func translation(for progress: Progress, scale: Scale) -> Translation {
			let xTranslation: CGFloat = xTranslation(for: progress, scale: scale)
			let yTranslation: CGFloat = yTranslation(for: progress, scale: scale)
			
			return Translation(x: xTranslation, y: yTranslation)
		}
		
		private func xTranslation(for progress: Progress, scale: Scale) -> CGFloat {
			let initialTranslation: CGFloat = presentedStateProps.translation.x
			
			let xTranslation: CGFloat =
			dismissedStateProps.translation.x
			* progress.value
			
			return xTranslation
		}
		
		private func yTranslation(for progress: Progress, scale: Scale) -> CGFloat {
			let initialTranslation: CGFloat = presentedStateProps.translation.y
			
			let toastScaledSizeDifference: CGFloat =
			((toastSize.height - (toastSize.height * scale.y)) / 2)
			
			let yTranslation: CGFloat =
			dismissedStateProps.translation.y
			* progress.value
			- toastScaledSizeDifference
			
			return yTranslation
		}
		
		private func cornerRadius(for progress: Progress) -> CornerRadius {
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
		
		private func shadowAlpha(for progress: Progress) -> CGFloat {
			let initialShadowAlpha: CGFloat = presentedStateProps.shadowIntensity.value
			
			let finalShadowAlpha: CGFloat = dismissedStateProps.shadowIntensity.value
			let shadowAlpha: CGFloat = finalShadowAlpha
			* progress.value
			+ initialShadowAlpha
			* progress.revertedValue
			
			return shadowAlpha
		}
    }
}
