//
//  CxjToastAnimator+CustomConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

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
							props.cornerRadius = radius
						}
					}
				}
			
			return resultAnimatingProperties
		}
	}
}
