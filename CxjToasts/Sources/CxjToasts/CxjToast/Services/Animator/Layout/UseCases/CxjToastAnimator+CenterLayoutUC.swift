//
//  CxjToastAnimator+CenterLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class CenterLayoutUseCase: BaseLayoutUseCase, LayoutUseCase {
        override var dismissedStateDefaultAnimatingProps: AnimatingProperties {
            AnimatingProperties(
                alpha: .zero,
                scale: CxjToastAnimator.AnimatingProperties.Scale(x: 0.5, y: 0.5),
                translationY: .zero,
                cornerRadius: .zero,
                shadowIntensity: .zero
            )
        }
        
		func presentingLayout() {
			setDefaultToastViewValues()
		}
	}
}
