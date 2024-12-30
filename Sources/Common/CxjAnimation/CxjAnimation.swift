//
//  CxjAnimation.swift
//
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

//MARK: - Animation
@MainActor
public struct CxjAnimation {
	public typealias Animations = (() -> Void)
	public typealias Completion = ((Bool) -> Void)
	public typealias Perform = (@escaping Animations, Completion?) -> Void
	
	public let perform: Perform
	
	public init(perform: @escaping Perform) {
		self.perform = perform
	}
}

//MARK: - Base Animations
public extension CxjAnimation {
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
	
	static let testSlow = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 1.0,
			delay: .zero,
			options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState],
			animations: animations,
			completion: completion
		)
	}
}

//MARK: - UIView + CxjAnimation
extension UIView {
	public static func animate(
		with animator: CxjAnimation,
		animations: @escaping CxjAnimation.Animations,
		completion: CxjAnimation.Completion?
	) {
		animator.perform(animations, completion)
	}
}
