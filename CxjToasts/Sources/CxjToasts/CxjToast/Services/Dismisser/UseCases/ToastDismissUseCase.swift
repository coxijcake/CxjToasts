//
//  ToastDismissUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

@MainActor
protocol ToastDismissUseCase {
	func activate()
	func deactivate()
	func pause()
}


