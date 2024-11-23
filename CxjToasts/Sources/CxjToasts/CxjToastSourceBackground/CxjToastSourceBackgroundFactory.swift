//
//  CxjToastSourceBackgroundFactory.swift
//
//
//  Created by Nikita Begletskiy on 31/10/2024.
//

import UIKit

@MainActor
public enum CxjToastSourceBackgroundFactory {
	typealias Background = CxjToastSourceBackground
	typealias Theme = CxjToastConfiguration.SourceBackground.Theme
	
	static func backgroundForTheme(_ theme: Theme?) -> Background? {
		switch theme {
		case .colorized(color: let color):
			let colorizedView: UIView = CxjColorizedBackgroundViewConfigurator
				.backgroundViewFor(color: color)
			return backgroundControlWithSubview(colorizedView)
		case .blurred(effect: let effect):
			let blurredView: UIView = CxjBlurredBackgroundViewConfigurator
				.backgroundBlurredViewWith(blurEffect: effect)
			return backgroundControlWithSubview(blurredView)
		case .gradient(params: let params):
			let gradientedView: UIView = CxjGradientdBackgroundViewConfigurator
				.gradientBackgroundViewWithParams(params)
			return backgroundControlWithSubview(gradientedView)
		case .custom(view: let customView):
			return backgroundControlWithSubview(customView)
		case .none:
			return nil
		}
	}
	
	private static func backgroundControlWithSubview(_ controlSubview: UIView) -> Background {
		let control: CxjToastSourceBackgroundControl = CxjToastSourceBackgroundControl()
		
		control.addSubview(controlSubview)
		controlSubview.isUserInteractionEnabled = false
		controlSubview.frame = control.bounds
		controlSubview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		return control
	}
}
