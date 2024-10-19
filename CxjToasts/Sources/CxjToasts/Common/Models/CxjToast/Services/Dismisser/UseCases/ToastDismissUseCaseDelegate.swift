//
//  ToastDismissUseCaseDelegate.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

protocol ToastDismissUseCaseDelegate: AnyObject {
	func didStartInteractive(by useCase: ToastDismissUseCase)
	func didEndInteractive(by useCase: ToastDismissUseCase)
	func didFinish(useCase: ToastDismissUseCase)
}