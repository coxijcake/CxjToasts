//
//  CxjAnimator.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Animator
struct CxjAnimator {
	typealias Animations = (() -> Void)
	typealias Completion = ((Bool) -> Void)
	
	let perform: (@escaping Animations, Completion?) -> ()
}

//MARK: - Base Animations
extension CxjAnimator {
	static let noAnimation = CxjAnimator { (animations, completion) in
		animations()
		completion?(true)
	}
	
	static let defaultSpring = CxjAnimator { (animations, completion) in
		UIView.animate(
			withDuration: 0.3,
			delay: .zero,
			options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction],
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - UIView + CxjAnimator
extension UIView {
	static func animate(
		with animator: CxjAnimator,
		animations: @escaping CxjAnimator.Animations,
		completion: CxjAnimator.Completion?
	) {
		animator.perform(animations, completion)
	}
}
