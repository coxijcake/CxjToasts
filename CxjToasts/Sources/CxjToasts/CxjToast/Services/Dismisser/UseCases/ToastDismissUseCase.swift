//
//  ToastDismissUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

enum ToastDimissMethod: CaseIterable {
	static var allUnqiueCases: Set<ToastDimissMethod> {
		Set(allCases)
	}
	
	case swipe
	case tap
	case time
}

enum ToastDismisserState {
	case active
	case inActive
	case paused
}

@MainActor
protocol ToastDismissUseCase {
	var dismissMethod: ToastDimissMethod { get }
	
	func setupState(_ state: ToastDismisserState)
}


