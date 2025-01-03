//
//  SmoothProgressCalculator.swift
//
//
//  Created by Nikita Begletskiy on 01/10/2024.
//

import Foundation

struct SmoothProgressCalculator {
	typealias Value = Float
	
	private let availableRange: ClosedRange<Value> = (0.0...1.0)
	
	@ClampedProgress var originalProgress: Value
	@ClampedProgress var threshold: Value

	init(originalProgress: Value, threshold: Value) {
		self._originalProgress = ClampedProgress(originalProgress, availableRange)
		self._threshold = ClampedProgress(threshold, availableRange)
	}
	
	func smoothedProgress() -> Value {
        guard threshold != .zero else { return originalProgress }
        
		if originalProgress <= threshold {
			return (originalProgress / threshold) * (threshold / 2)
		} else {
			return (originalProgress - threshold)
			/ (1 - threshold)
			* (1 - threshold / 2)
			+ (threshold / 2)
		}
	}
}
