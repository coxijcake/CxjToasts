//
//  CxjToastAnimator+AnimatorLayoutUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

extension CxjToastAnimator {
	protocol AnimatorLayoutUseCase {
		func beforeDisplayingLayout(progress: ToastLayoutProgress)
		func presentingLayout()
		func dismissLayout(progress: ToastLayoutProgress)
	}
}
