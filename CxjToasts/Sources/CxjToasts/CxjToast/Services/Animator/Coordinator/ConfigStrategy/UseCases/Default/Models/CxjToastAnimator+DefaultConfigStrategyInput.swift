//
//  CxjToastAnimator+DefaultConfigStrategyInput.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation
import UIKit.UIView

extension CxjToastAnimator {
	struct ConfigStrategyCommonInput {
		struct SourceViewData {
			let frame: CGRect
			let safeAreaInsets: UIEdgeInsets
		}
		
		struct ToastViewData {
			let size: CGSize
			let placement: CxjToastConfiguration.Layout.Placement
		}
		
		let presentedStateAnimatingProperties: AnimatingProperties
		let toastViewData: ToastViewData
		let sourceViewData: SourceViewData
	}
}
