//
//  CxjToastContainer+BlurredBackgroundConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 19/10/2024.
//

import UIKit

extension CxjToastContainerBackgroundViewFactory {
	enum CxjToastContainerBlurredBackgroundViewConfigurator {
		static func backgroundBlurredViewWith(
			blurEffect: UIBlurEffect?
		) -> UIView {
			let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
			
			return blurView
		}
	}
}
