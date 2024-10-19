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
		}
	}
}

extension CxjToastContainerBackgroundViewFactory {
	enum CxjToastContainerColorizedBackgroundViewConfigurator {
		static func backgroundViewFor(color: UIColor) -> UIView {
			let view: UIView = UIView()
			view.backgroundColor = color
			view.clipsToBounds = true
			
			return view
		}
	}
}
