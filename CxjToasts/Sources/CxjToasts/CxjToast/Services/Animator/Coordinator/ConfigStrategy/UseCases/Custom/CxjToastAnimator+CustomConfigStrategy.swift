//
//  CxjToastAnimator+CustomConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIScreen

extension CxjToastAnimator {
	struct CustomConfigStrategy: ConfigStrategy {
		typealias Change = ToastConfig.Animations.Behaviour.CustomBehaviourChange
		typealias Changes = ToastConfig.Animations.Behaviour.CustomBehaviourChanges
		
		let presentedStateAnimatingProperties: AnimatingProperties
		let changes: Changes
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let builder = CustomConfigPropertiesBuilder(initialProperties: presentedStateAnimatingProperties)
			   
			for change in changes {
				builder.update(with: change)
			}
			
			let customAnimatingProperties: AnimatingProperties = builder.build()
			
			return customAnimatingProperties
		}
	}
}

//MARK: - Custom Config Properties Builder
extension CxjToastAnimator.CustomConfigStrategy {
	private final class CustomConfigPropertiesBuilder {
		typealias AnimatingProperties = CxjToastAnimator.AnimatingProperties
		typealias Animations = CxjToastConfiguration.Animations
		
		private var alpha: ClampedAlpha
		private var scale: AnimatingProperties.Scale
		private var translation: AnimatingProperties.Translation
		private var cornerRadius: AnimatingProperties.CornerRadius
		private var shadow: AnimatingProperties.Shadow
		
		init(initialProperties: AnimatingProperties) {
			self.alpha = initialProperties.alpha
			self.scale = initialProperties.scale
			self.translation = initialProperties.translation
			self.cornerRadius = initialProperties.cornerRadius
			self.shadow = initialProperties.shadow
		}
		
		func update(with change: Change) -> CustomConfigPropertiesBuilder {
			switch change {
			case .scale(let value):
				scale = AnimatingProperties.Scale(x: value.x, y: value.y)
			case .translation(let value):
				translation = AnimatingProperties.Translation(x: value.x, y: value.y)
			case .alpha(let intensity):
				alpha = ClampedAlpha(value: intensity)
			case .shadow(let color, let intensity):
				shadow = .on(color: color, alpha: ClampedAlpha(value: intensity))
			case .corners(let radius):
				cornerRadius = cornerRadiusValue(for: radius)
			}
			
			return self
		}
		
		func build() -> AnimatingProperties {
			return AnimatingProperties(
				alpha: alpha,
				scale: scale,
				translation: translation,
				cornerRadius: cornerRadius,
				shadow: shadow
			)
		}
		
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
