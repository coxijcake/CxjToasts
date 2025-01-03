//
//  CxjToastAnimator+DefaultConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	@MainActor
	enum DefaultConfigStrategyFactory {
		static func configStrategy(
			placement: CxjToastConfiguration.Layout.Placement,
			adjustForTopFeatures: Set<CxjToastConfiguration.Animation.TopScreenFeature>,
			input: ConfigStrategyCommonInput
		) -> CxjToastAnimationPropertiesConfigStrategy {
			switch placement {
			case .top(let params):
				DefaultTopConfigStrategyFactory.configStrategy(
					input: input,
					adjustForTopFeatures: adjustForTopFeatures,
					includingSafeArea: params.includingSafeArea,
					verticalOffset: params.offset
				)
			case .center:
				DefaultCenterConfigStrategy(input: input)
			case .bottom(let params):
				DefaultBottomConfigStrategy(
					input: input,
					includingSafeArea: params.includingSafeArea,
					verticalOffset: params.offset
				)
			}
		}
	}
}
