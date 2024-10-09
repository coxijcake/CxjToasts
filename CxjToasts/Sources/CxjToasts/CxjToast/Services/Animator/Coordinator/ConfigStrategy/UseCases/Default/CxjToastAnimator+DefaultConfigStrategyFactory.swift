//
//  CxjToastAnimator+DefaultConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	enum DefaultConfigStrategyFactory {
		static func configStrategy(
			placement: CxjToastConfiguration.Layout.Placement,
			input: ConfigStrategyCommonInput
		) -> DefaultConfigStrategy {
			switch placement {
			case .top(let safeArea, let verticalOffset):
				DefaultTopConfigStrategyFactory.configStrategy(
					input: input,
					includingSafeArea: safeArea,
					verticalOffset: verticalOffset
				)
			case .center:
				DefaultCenterConfigStrategy(input: input)
			case .bottom(let safeArea, let verticalOffset):
				DefaultBottomConfigStrategy(
					input: input,
					includingSafeArea: safeArea,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
