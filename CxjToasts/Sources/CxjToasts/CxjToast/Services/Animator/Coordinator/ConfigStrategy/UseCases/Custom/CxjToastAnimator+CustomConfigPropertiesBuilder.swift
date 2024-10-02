//
//  CxjToastAnimator+CustomConfigPropertiesBuilder.swift
//
//
//  Created by Nikita Begletskiy on 02/10/2024.
//

import Foundation
import UIKit.UIScreen

extension CxjToastAnimator {
	final class CustomConfigPropertiesBuilder {
		//MARK: - Types
		typealias Animations = CxjToastConfiguration.Animations
		typealias Input = ConfigStrategyCommonInput
		typealias Change = ToastConfig.Animations.Behaviour.CustomBehaviourChange
		
		//MARK: - Props
		let input: Input
		
		private var alpha: ClampedAlpha
		private var scale: AnimatingProperties.Scale
		private var translation: AnimatingProperties.Translation
		private var cornerRadius: AnimatingProperties.CornerRadius
		private var shadowOverlay: AnimatingProperties.ShadowOverlay
		
		//MARK: - Lifecycle
		init(input: Input) {
			self.input = input
			self.alpha = input.presentedStateAnimatingProperties.alpha
			self.scale = input.presentedStateAnimatingProperties.scale
			self.translation = input.presentedStateAnimatingProperties.translation
			self.cornerRadius = input.presentedStateAnimatingProperties.cornerRadius
			self.shadowOverlay = input.presentedStateAnimatingProperties.shadowOverlay
		}
		
		//MARK: - Updating
		func update(with change: Change) -> CustomConfigPropertiesBuilder {
			switch change {
			case .scale(let value):
				scale = AnimatingProperties.Scale(x: value.x, y: value.y)
			case .translation(let type):
				translation = translationFor(translationType: type)
			case .alpha(let intensity):
				alpha = ClampedAlpha(value: intensity)
			case .shadowOverlay(let color, let intensity):
				shadowOverlay = .on(color: color, alpha: ClampedAlpha(value: intensity))
			case .corners(let radius):
				cornerRadius = cornerRadiusValue(for: radius)
			}
			
			return self
		}
		
		//MARK: - Building
		func build() -> AnimatingProperties {
			return AnimatingProperties(
				alpha: alpha,
				scale: scale,
				translation: translation,
				cornerRadius: cornerRadius,
				shadowOverlay: shadowOverlay
			)
		}
		
		//MARK: - Translation
		private func translationFor(translationType: Change.TranslationType) -> AnimatingProperties.Translation {
			switch translationType {
			case .outOfSourceViewVerticaly: 
				return outOfSourceViewVerticalTranslation()
			case .custom(value: let value):
				return AnimatingProperties.Translation(x: value.x, y: value.y)
			}
		}
		
		private func outOfSourceViewVerticalTranslation() -> AnimatingProperties.Translation {
			let tranlationX: CGFloat = .zero
			
			switch input.toastViewData.placement {
			case .top(let verticalOffset):
				let translationY: CGFloat =
				verticalOffset
				+ input.sourceViewData.safeAreaInsets.top
				+ input.toastViewData.size.height
				
				return AnimatingProperties.Translation(
					x: tranlationX,
					y: -translationY
				)
			case .center:
				return AnimatingProperties.Translation(
					x: tranlationX,
					y: .zero
				)
			case .bottom(let verticalOffset):
				let translationY: CGFloat =
				verticalOffset
				+ input.sourceViewData.safeAreaInsets.bottom
				+ input.toastViewData.size.height
				
				return AnimatingProperties.Translation(
					x: tranlationX,
					y: translationY
				)
			}
		}
		
		//MARK: - CornerRadius
		private func cornerRadiusValue(
			for cornerRadius: Animations.Behaviour.CustomBehaviourChange.CornerRadius
		) -> AnimatingProperties.CornerRadius {
			let constraint: AnimatingProperties.CornerRadius.Constraint = {
				switch cornerRadius.constraint {
				case .halfHeigt: .halfHeight
				case .none: .none
				}
			}()
			
			let value: CGFloat = {
				switch cornerRadius.type {
				case .screenCornerRadius: UIScreen.main.displayCornerRadius
				case .custom(value: let value): value
				}
			}()
			
			return AnimatingProperties.CornerRadius(
				value: value,
				constraint: constraint
			)
		}
	}
}
