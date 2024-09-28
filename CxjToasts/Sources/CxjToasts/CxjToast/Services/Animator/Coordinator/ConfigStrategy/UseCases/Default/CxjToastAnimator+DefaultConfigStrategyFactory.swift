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
			input: DefaultConfigStrategyInput
		) -> DefaultConfigStrategy {
			switch placement {
			case .top(let verticalOffset):
				DefaultTopConfigStrategyFactory.configStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			case .center:
				DefaultCenterConfigStrategy(input: input)
			case .bottom(let verticalOffset):
				DefaultBottomConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
