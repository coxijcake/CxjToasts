//
//  ClampedAlpha.swift
//
//
//  Created by Nikita Begletskiy on 28/09/2024.
//

import Foundation

struct ClampedAlpha {
	@ClampedProgress var value: CGFloat
	
	static var min: ClampedAlpha { ClampedAlpha(value: .zero) }
	static var max: ClampedAlpha { ClampedAlpha(value: 1.0) }
	
	init(value: CGFloat) {
		self._value = ClampedProgress(value, 0.0...1.0)
	}
}


extension ClampedAlpha: Changeable {
	init(copy: ChangeableWrapper<Self>) {
		self.init(
			value: copy.value
		)
	}
}
