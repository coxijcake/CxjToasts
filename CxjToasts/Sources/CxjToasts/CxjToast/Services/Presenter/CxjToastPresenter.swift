//
//  CxjToastPresenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Interface
protocol CxjToastPresentable {
	var animator: CxjToastPresentAnimator { get }
	
	func present(animated: Bool, completion: BoolCompletion?)
}

//MARK: - Implementation
final class CxjToastPresenter: CxjToastPresentable {
	let config: CxjToastConfiguration
	let toastView: CxjToastView
	let sourceBackgroundView: CxjToastSourceBackground?
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
	}
	
	func present(animated: Bool, completion: BoolCompletion?) {
		if let sourceBackgroundView {
			LayoutApplier.applyLayoutForBackgroundView(
				sourceBackgroundView,
				inSourceView: config.sourceView
			)
		}
		
		LayoutApplier.applyToastLayout(
			config.layout,
			forToastView: toastView,
			inSourceView: config.sourceView
		)
        
        toastView.prepareToDisplay()
		
		animator.presentAction(animated: animated, completion: completion)
	}
}
