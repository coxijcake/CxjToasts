//
//  ToastDismissUseCaseDelegate.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

@MainActor
protocol ToastDismissUseCaseDelegate: AnyObject {
	func didStartInteractive(by useCase: ToastDismissUseCase)
	func didEndInteractive(by useCase: ToastDismissUseCase)
	func didUpdateRemainingDisplayingTime(
		_ time: TimeInterval,
		initialDisplayingTime: TimeInterval,
		by useCase: ToastDismissUseCase
	)
	
	func didFinish(useCase: ToastDismissUseCase)
}
