//
//  ClampedAlpha.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

struct ClampedAlpha {
	private static let minValue: CGFloat = .zero
	private static let maxValue: CGFloat = 1.0
	
	static var min: ClampedAlpha { ClampedAlpha(value: minValue) }
	static var max: ClampedAlpha { ClampedAlpha(value: maxValue) }
	
	@ClampedProgress var value: CGFloat
	
	init(value: CGFloat) {
		self._value = ClampedProgress(value, ClampedAlpha.minValue...ClampedAlpha.maxValue)
	}
}

//MARK: - Changeable
extension ClampedAlpha: Changeable {
	init(copy: ChangeableWrapper<Self>) {
		self.init(
			value: copy.value
		)
	}
}
