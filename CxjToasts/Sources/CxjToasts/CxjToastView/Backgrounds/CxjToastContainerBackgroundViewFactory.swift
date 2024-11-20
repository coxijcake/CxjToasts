//
//  CxjToastContainerBackgroundViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 14/10/2024.
//

import UIKit

public enum CxjToastContainerBackgroundViewFactory {
	typealias Background = CxjBackground
	typealias BackgroundView = UIView
	
	static func backroundViewFor(background: Background) -> BackgroundView {
		switch background {
		case .colorized(color: let color):
			CxjColorizedBackgroundViewConfigurator
				.backgroundViewFor(color: color)
		case .blurred(effect: let effect):
			CxjBlurredBackgroundViewConfigurator
				.backgroundBlurredViewWith(blurEffect: effect)
		case .gradient(params: let params):
			CxjGradientdBackgroundViewConfigurator
				.gradientBackgroundViewWithParams(params)
		case .custom(view: let customView):
			customView
		}
	}
}
