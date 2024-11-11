//
//  BounceOnTouchUIButton.swift
//  Example
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

class BounceOnTouchButton: UIButton {
	// MARK: - Touches overriden
	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		update(isTracking: true)
		
		return super.beginTracking(touch, with: event)
	}

	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)
		
		update(isTracking: false)
	}

	override func cancelTracking(with event: UIEvent?) {
		super.cancelTracking(with: event)
		
		update(isTracking: false)
	}
}

// MARK: - UI updating for touches
private extension BounceOnTouchButton {
	func update(isTracking: Bool, animated: Bool = true) {
		let transform: CGAffineTransform = isTracking ? .init(scaleX: 0.95, y: 0.95) : .identity
		let alpha: CGFloat = isTracking ? 0.95 : 1
		let animations: (() -> Void) = {
			self.transform = transform
			self.alpha = alpha
		}

		if animated {
			UIView.animate(
				withDuration: 0.15,
				delay: .zero,
				options: [
					.allowUserInteraction,
					.curveLinear,
					.beginFromCurrentState
				],
				animations: animations
			)
		} else {
			animations()
		}
	}
}
