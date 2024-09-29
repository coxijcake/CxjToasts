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
		typealias Changes = ToastConfig.Animations.Behaviour.CustomBehaviourChanges
		
		let presentedStateAnimatingProperties: AnimatingProperties
		let changes: Changes
		
		func dismissedStateAnimatingProperties() -> CxjToastAnimator.AnimatingProperties {
			let resultAnimatingProperties: AnimatingProperties = presentedStateAnimatingProperties
				.changing { props in
					for change in changes {
						switch change {
						case .scale(let value):
							props.scale = .init(x: value.x, y: value.y)
						case .translation(let value):
							props.translation = .init(x: value.x, y: value.y)
						case .alpha(let intensity):
							props.alpha = .init(value: intensity)
						case .shadow(let intensity):
							props.shadowIntensity = .init(value: intensity)
						case .corners(let radius):
							props.cornerRadius = cornerRadiusValue(
								for: radius
							)
						}
					}
				}
			
			return resultAnimatingProperties
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
