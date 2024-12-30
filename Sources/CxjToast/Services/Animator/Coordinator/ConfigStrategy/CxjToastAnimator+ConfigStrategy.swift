//
//  CxjToastAnimator+ConfigStrategy.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

extension CxjToastAnimator {
	@MainActor
	protocol ConfigStrategy {
		func dismissedStateAnimatingProperties() -> ToastAnimatingProperties
	}
}
