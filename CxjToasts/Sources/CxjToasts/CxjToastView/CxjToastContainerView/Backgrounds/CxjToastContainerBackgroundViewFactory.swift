//
//  CxjToastContainerBackgroundViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 14/10/2024.
//

import UIKit

enum CxjToastContainerBackgroundViewFactory {
	typealias BackgroundView = UIView
	typealias Config = CxjToastViewConfiguration.Background
	
	static func backroundViewFor(config: Config) -> BackgroundView {
		switch config {
		case .colorized(color: let color):
			CxjToastContainerColorizedBackgroundViewConfigurator
				.backgroundViewFor(color: color)
		case .blurred(effect: let effect):
			CxjToastContainerBlurredBackgroundViewConfigurator
				.backgroundBlurredViewWith(blurEffect: effect)
		}
	}
}
