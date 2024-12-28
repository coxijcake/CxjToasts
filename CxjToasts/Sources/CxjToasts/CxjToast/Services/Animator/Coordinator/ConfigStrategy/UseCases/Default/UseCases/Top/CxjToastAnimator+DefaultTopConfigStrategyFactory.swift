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
			usingAnimationNativeViews: Set<CxjToastConfiguration.Animation.TopScreenFeature>,
			includingSafeArea: Bool,
			verticalOffset: CGFloat
		) -> DefaultTopConfigStrategy {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = input.sourceViewData.safeAreaInsets
			
			let isSourceSafeAreaEqulWindowSafeArea: Bool =
			(applicationSafeAreaInsets == sourceViewSafeAreaInsets)
			&& includingSafeArea
			
			return if isSourceSafeAreaEqulWindowSafeArea,
					  usingAnimationNativeViews.contains(.dynamicIsland),
					  CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
				DefaultTopDynamicIslandConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			} else if isSourceSafeAreaEqulWindowSafeArea,
					  usingAnimationNativeViews.contains(.notch),
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
