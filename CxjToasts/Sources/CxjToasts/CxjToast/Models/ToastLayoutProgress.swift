//
//  ToastLayoutProgress.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

struct ToastLayoutProgress {
	private static let minValue: CGFloat = .zero
	private static let maxValue: CGFloat = 1.0
	
	static var min: ToastLayoutProgress { ToastLayoutProgress(value: minValue) }
	static var max: ToastLayoutProgress { ToastLayoutProgress(value: maxValue) }
	
	@ClampedProgress var value: CGFloat
	var revertedValue: CGFloat { _value.upperValue - value }
	
	init(value: CGFloat) {
		self._value = ClampedProgress(value, ToastLayoutProgress.minValue...ToastLayoutProgress.maxValue)
	}
}
