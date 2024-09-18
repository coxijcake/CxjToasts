//
//  CxjToastAnimator+LayoutUC.swift
//  
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

extension CxjToastAnimator {
	protocol LayoutUseCase {
        var dismissedStateYTranslation: CGFloat { get }
        
		func beforeDisplayingLayout(progress: ToastLayoutProgress)
		func presentingLayout()
		func dismissLayout(progress: ToastLayoutProgress)
	}
}
