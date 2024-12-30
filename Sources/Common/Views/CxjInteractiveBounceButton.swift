//
//  CxjInteractiveBounceButton.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/11/2024.
//

import UIKit

public class CxjInteractiveBounceButton: UIButton {
	//MARK: - Animating props values
	var alphaOnTouch: CGFloat { 0.975 }
	var defaultAlpha: CGFloat { 1.0 }
	
	var scaleOnTouch: CGFloat { 0.985 }
	var defaultTransform: CGAffineTransform { .identity }
	
	// MARK: - Touches overriden
	public override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		updateUI(isTouching: true, animated: true)
		
		return super.beginTracking(touch, with: event)
	}

	public override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		super.endTracking(touch, with: event)
		
		updateUI(isTouching: false, animated: true)
	}

	public override func cancelTracking(with event: UIEvent?) {
		super.cancelTracking(with: event)
		
		updateUI(isTouching: false, animated: false)
	}
}

// MARK: - Touches tracking update
private extension CxjInteractiveBounceButton {
	func updateUI(isTouching: Bool, animated: Bool) {
		let alpha: CGFloat = isTouching ? alphaOnTouch : defaultAlpha
		let transform: CGAffineTransform = isTouching ? .init(scaleX: scaleOnTouch, y: scaleOnTouch) : defaultTransform
		let animations: CxjVoidCompletion = {
			self.alpha = alpha
			self.transform = transform
		}

		if animated {
			UIView.animate(
				withDuration: 0.15,
				delay: .zero,
				options: [
					.allowUserInteraction,
					.beginFromCurrentState,
					.curveLinear,
				],
				animations: animations
			)
		} else {
			animations()
		}
	}
}
