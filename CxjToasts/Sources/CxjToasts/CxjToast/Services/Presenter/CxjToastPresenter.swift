//
//  CxjToastPresenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

enum CxjToastPresenter {
    static func present(toast: CxjToastable) {
		let config: CxjToastConfiguration = toast.config
		let toastView: CxjToastView = toast.view
		
		let animator: ToastAnimator = ToastAnimator(
			toastView: toastView,
			config: config
		)
		
		LayoutApplier.apply(
			layout: config.layout,
			for: toastView,
			in: config.sourceView
		)
				
		animator.showAction()
		
		let displayingTime: TimeInterval? = {
			for hidingMethod in config.hidingMethods {
				switch hidingMethod {
				case .automatic(let time): return time
				default: continue
				}
			}
			return nil
		}()
		
		if let displayingTime {
			DispatchQueue.main.asyncAfter(deadline: .now() + displayingTime) {
				animator.hideAction { [weak toastView] _ in
					toastView?.removeFromSuperview()
				}
			}
		}
    }
}
