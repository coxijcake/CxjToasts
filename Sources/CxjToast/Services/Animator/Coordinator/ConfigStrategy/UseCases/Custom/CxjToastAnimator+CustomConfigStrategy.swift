//
//  CxjToastAnimator+CustomConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	@MainActor
	struct CustomConfigStrategy: CxjToastAnimationPropertiesConfigStrategy {
		typealias Changes = ToastConfig.Animation.Behaviour.CustomBehaviourChanges
		
		let input: ConfigStrategyCommonInput
		let presentedStateAnimatingProperties: ToastAnimatingProperties
		let changes: Changes
		
		func dismissedStateAnimatingProperties() -> ToastAnimatingProperties {
			let builder = CustomConfigPropertiesBuilder(input: input)
			   
			for change in changes {
				builder.update(with: change)
			}
			
			let customAnimatingProperties: ToastAnimatingProperties = builder.build()
			
			return customAnimatingProperties
		}
	}
}
