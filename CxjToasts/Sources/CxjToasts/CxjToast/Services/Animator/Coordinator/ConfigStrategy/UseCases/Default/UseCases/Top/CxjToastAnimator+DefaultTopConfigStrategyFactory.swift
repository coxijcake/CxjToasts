//
//  CxjToastAnimator+DefaultTopConfigStrategyFactory.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIApplication

extension CxjToastAnimator {
	@MainActor
	enum DefaultTopConfigStrategyFactory {
		static func configStrategy(
			input: ConfigStrategyCommonInput,
			includingSafeArea: Bool,
			verticalOffset: CGFloat
		) -> DefaultTopConfigStrategy {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = input.sourceViewData.safeAreaInsets
			
			//TODO: - Add to global toasts settings
			let isSourceSafeAreaEqulWindowSafeArea: Bool = 
			(applicationSafeAreaInsets == sourceViewSafeAreaInsets)
			&& includingSafeArea
			
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
					includingSafeArea: includingSafeArea,
					verticalOffset: verticalOffset
				)
			}
		}
	}
}
