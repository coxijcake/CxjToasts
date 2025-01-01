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
			adjustForTopFeatures: Set<CxjToastConfiguration.Animation.TopScreenFeature>,
			includingSafeArea: Bool,
			verticalOffset: CGFloat
		) -> CxjToastAnimationPropertiesConfigStrategy {
			let applicationSafeAreaInsets: UIEdgeInsets = UIApplication.safeAreaInsets
			let sourceViewSafeAreaInsets: UIEdgeInsets = input.sourceViewData.safeAreaInsets
			
			let isSourceSafeAreaEqulWindowSafeArea: Bool =
			(applicationSafeAreaInsets == sourceViewSafeAreaInsets)
			&& includingSafeArea
			
			return if isSourceSafeAreaEqulWindowSafeArea,
					  adjustForTopFeatures.contains(.dynamicIsland),
					  CxjDynamicIslandHelper.isDynamicIslandInDefaultPosition {
				DefaultTopDynamicIslandConfigStrategy(
					input: input,
					verticalOffset: verticalOffset
				)
			} else if isSourceSafeAreaEqulWindowSafeArea,
					  adjustForTopFeatures.contains(.notch),
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
