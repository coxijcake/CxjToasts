//
//  CxjToastAnimator+DefaultTopConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIApplication

extension CxjToastAnimator {
	enum DefaultTopConfigStrategyFactory {
		static func configStrategy(
			input: ConfigStrategyCommonInput,
			verticalOffset: CGFloat
		) -> DefaultTopConfigStrategy {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = input.sourceViewData.safeAreaInsets
			
			//TODO: - Add to global toasts settings
			let isSourceSafeAreaEqulWindowSafeArea: Bool = applicationSafeAreaInsets == sourceViewSafeAreaInsets
			
			return if isSourceSafeAreaEqulWindowSafeArea,
					  CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
				DefaultTopDynamicIslandConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			} else if isSourceSafeAreaEqulWindowSafeArea,
					  CxjNotchHelper.isNotchInDefaultPosition {
				DefaultTopNotchConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			} else {
				DefaultTopCommonConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
