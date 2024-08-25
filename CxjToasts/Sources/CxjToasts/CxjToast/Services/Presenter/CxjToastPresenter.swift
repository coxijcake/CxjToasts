//
//  CxjToastPresenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

final class CxjToastPresenter {
	let config: CxjToastConfiguration
	let toastView: CxjToastView
	let animator: CxjToastAnimator
	
	init(
		config: CxjToastConfiguration,
		toastView: CxjToastView,
		animator: CxjToastAnimator
	) {
		self.config = config
		self.toastView = toastView
		self.animator = animator
	}
	
	func present() {
		LayoutApplier.apply(
			layout: config.layout,
			for: toastView,
			in: config.sourceView
		)
				
		animator.showAction()
	}
}
