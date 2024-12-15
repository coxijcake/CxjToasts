//
//  CxjToastPresenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Interface
@MainActor
protocol CxjToastPresentable: Sendable {
	var animator: CxjToastPresentAnimator { get }
	
	func present(animated: Bool, keyboardState: CxjKeyboardDisplayingState, completion: CxjBoolCompletion?)
	func updateForKeyboardState(_ keyboardState: CxjKeyboardDisplayingState, animated: Bool)
}

//MARK: - Implementation
@MainActor
final class CxjToastPresenter: CxjToastPresentable {
	let config: CxjToastConfiguration
	let toastView: CxjToastView
	let sourceBackgroundView: CxjToastSourceBackground?
	
	let layoutApplier: LayoutApplier
	let animator: CxjToastPresentAnimator
	
	init(
		config: CxjToastConfiguration,
		toastView: CxjToastView,
		sourceBackgroundView: CxjToastSourceBackground?,
		animator: CxjToastPresentAnimator
	) {
		self.config = config
		self.toastView = toastView
		self.sourceBackgroundView = sourceBackgroundView
		self.animator = animator
		self.layoutApplier = LayoutApplier(
			toastView: toastView,
			sourceView: config.sourceView,
			updatingForKeyboardStrategy: .init(toastConfig: config, toastView: toastView)
		)
	}
	
	func present(animated: Bool, keyboardState: CxjKeyboardDisplayingState, completion: CxjBoolCompletion?) {
		if let sourceBackgroundView {
			layoutApplier.applyLayoutForBackgroundView(
				sourceBackgroundView,
				inSourceView: config.sourceView
			)
		}
		
		layoutApplier.applyToastLayout(
			config.layout,
			keyboardState: keyboardState
		)
        
        toastView.prepareToDisplay()
		
		animator.presentAction(animated: animated, completion: completion)
	}
	
	func updateForKeyboardState(_ keyboardState: CxjKeyboardDisplayingState, animated: Bool) {
		layoutApplier.updateLayoutForKeyboardState(keyboardState, animated: animated)
	}
}
