//
//  CxjToastAnimator+Layouter.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import Foundation

extension CxjToastAnimator {
	@MainActor
	protocol Coordinator {
        var dismissedStateTranslation: CGPoint { get }
        
		func beforeDisplayingLayout(progress: ToastLayoutProgress)
		func presentingLayout()
		func dismissLayout(progress: ToastLayoutProgress)
	}
}