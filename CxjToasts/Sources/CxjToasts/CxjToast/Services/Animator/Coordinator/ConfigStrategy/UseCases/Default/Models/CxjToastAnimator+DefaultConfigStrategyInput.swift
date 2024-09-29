//
//  CxjToastAnimator+DefaultConfigStrategyInput.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct DefaultConfigStrategyInput {
		let presentedStateAnimatingProperties: AnimatingProperties
		let toastSize: CGSize
		let sourceViewSafeAreaInsets: UIEdgeInsets
	}
}
