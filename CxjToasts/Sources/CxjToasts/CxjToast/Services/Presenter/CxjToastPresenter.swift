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
	
	func present(completion: BoolCompletion?)
}

//MARK: - Implementation
final class CxjToastPresenter: CxjToastPresentable {
	let config: CxjToastConfiguration
	let toastView: CxjToastView
	let animator: CxjToastPresentAnimator
	
	init(
		config: CxjToastConfiguration,
		toastView: CxjToastView,
		animator: CxjToastPresentAnimator
	) {
		self.config = config
		self.toastView = toastView
		self.animator = animator
	}
	
	func present(completion: BoolCompletion?) {
		LayoutApplier.apply(
			layout: config.layout,
			for: toastView,
			in: config.sourceView
		)
        
        toastView.prepareToDisplay()
				
		animator.presentAction(completion: completion)
	}
}
