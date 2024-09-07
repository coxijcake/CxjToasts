//
//  ToastLayoutProgress.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

struct ToastLayoutProgress {
	@ClampedProgress var value: CGFloat
	
	var revertedValue: CGFloat { _value.upperValue - value }
	
	init(value: CGFloat) {
		self._value = ClampedProgress(value, 0.0...1.0)
	}
}
