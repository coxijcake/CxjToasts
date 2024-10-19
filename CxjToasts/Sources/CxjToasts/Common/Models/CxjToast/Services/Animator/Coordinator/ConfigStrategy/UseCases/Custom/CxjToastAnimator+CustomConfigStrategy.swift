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
		
		let input: ConfigStrategyCommonInput
		let presentedStateAnimatingProperties: AnimatingProperties
		let changes: Changes
		
		func dismissedStateAnimatingProperties() -> AnimatingProperties {
			let builder = CustomConfigPropertiesBuilder(input: input)
			   
			for change in changes {
				builder.update(with: change)
			}
			
			let customAnimatingProperties: AnimatingProperties = builder.build()
			
			return customAnimatingProperties
		}
	}
}
