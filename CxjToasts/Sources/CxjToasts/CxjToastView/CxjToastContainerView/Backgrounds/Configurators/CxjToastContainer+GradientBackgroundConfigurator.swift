//
//  CxjToastContainer+GradientBackgroundConfigurator.swift
//  
//
//  Created by Nikita Begletskiy on 19/10/2024.
//

import UIKit

extension CxjToastContainerBackgroundViewFactory {
	enum CxjToastContainerGradientdBackgroundViewConfigurator {
		static func gradientBackgroundViewWithParams(_ gradientParams: CxjGradientParams) -> UIView {
			let view: CxjToastGradientBackgroundView = CxjToastGradientBackgroundView(frame: .zero)
			let gradientState: CxjToastGradientBackgroundView.GradientState = .init(
				colors: gradientParams.colors.map { $0.cgColor },
				startPoint: gradientParams.direction.startPoint,
				endPoint: gradientParams.direction.endPoint,
				locations: gradientParams.locations?.map { NSNumber(value: $0) }
			)
			
			view.updateGradientState(gradientState)
			
			return view
		}
	}
}
