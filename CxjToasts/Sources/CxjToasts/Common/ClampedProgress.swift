//
//  ClampedProgress.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

@propertyWrapper
struct ClampedProgress<Value: Comparable> {
	private var value: Value
	private let range: ClosedRange<Value>
	
	init(
		_ wrappedValue: Value,
		_ range: ClosedRange<Value>
	) {
		self.range = range
		self.value = min(
			max(wrappedValue, range.lowerBound),
			range.upperBound
		)
	}
	
	var wrappedValue: Value {
		get { value }
		set { value = min(max(newValue, range.lowerBound), range.upperBound)}
	}
	
	var upperValue: Value {
		range.upperBound
	}
	
	var lowerValue: Value {
		range.lowerBound
	}
	
	var projectedValue: (isAtLowerBound: Bool, isAtUpperBound: Bool) {
		(value == range.lowerBound, value == range.upperBound)
	}
}
