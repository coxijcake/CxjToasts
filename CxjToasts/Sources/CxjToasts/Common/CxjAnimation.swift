//
//  CxjAnimation.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Animation
struct CxjAnimation {
	typealias Animations = (() -> Void)
	typealias Completion = ((Bool) -> Void)
	
	let perform: (@escaping Animations, Completion?) -> ()
}

//MARK: - Base Animations
extension CxjAnimation {
	static let noAnimation = CxjAnimation { (animations, completion) in
		animations()
		completion?(true)
	}
	
	static let defaultSpring = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 0.3,
			delay: .zero,
			options: [.curveEaseInOut, .beginFromCurrentState, .allowUserInteraction],
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - UIView + CxjAnimation
extension UIView {
	static func animate(
		with animator: CxjAnimation,
		animations: @escaping CxjAnimation.Animations,
		completion: CxjAnimation.Completion?
	) {
		animator.perform(animations, completion)
	}
}
