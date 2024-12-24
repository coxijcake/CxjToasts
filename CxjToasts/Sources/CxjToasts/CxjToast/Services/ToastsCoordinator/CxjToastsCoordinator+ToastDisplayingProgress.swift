//
//  CxjToastsCoordinator+ToastDisplayingProgress.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import Foundation

extension CxjToastsCoordinator {
	struct ToastDisplayingProgress {
		private static let minValue: Float = .zero
		private static let maxValue: Float = 1.0
		
		static var min: ToastDisplayingProgress { ToastDisplayingProgress(value: minValue) }
		static var max: ToastDisplayingProgress { ToastDisplayingProgress(value: maxValue) }
		
		@ClampedProgress var value: Float
		
		var reverted: Float {
			_value.upperValue - value
		}
		
		init(value: Float) {
			self._value = ClampedProgress(value, ToastDisplayingProgress.minValue...ToastDisplayingProgress.maxValue)
		}
	}
}
