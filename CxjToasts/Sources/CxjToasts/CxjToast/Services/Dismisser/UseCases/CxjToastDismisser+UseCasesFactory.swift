//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

extension CxjToastDismisser {
	enum CxjToastDismissUseCaseFactory {
		typealias Configuration = CxjToastConfiguration
		typealias DismissMethod = Configuration.DismissMethod
		typealias ToastView = CxjToastView
		typealias Placement = Configuration.Layout.Placement
		typealias Animator = CxjToastAnimator
		
		static func useCase(
			for method: DismissMethod,
			toastView: ToastView,
			placement: Placement,
			animator: Animator,
			delegate: ToastDismissUseCaseDelegate?
		) -> ToastDismissUseCase {
			switch method {
			case .tap:
				DimissByTouchUseCase(
					toastView: toastView,
					delegate: delegate
				)
			case .automatic(time: let time):
				DimissByTimeUseCase(
					displayingTime: time,
					delegate: delegate
				)
			case .swipe(direction: let direction):
				DismissBySwipeUseCase(
					toastView: toastView,
					direction: direction,
					placement: placement,
					animator: animator,
					delegate: delegate
				)
			}
		}
	}
}
