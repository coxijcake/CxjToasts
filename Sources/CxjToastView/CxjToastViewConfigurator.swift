//
//  CxjToastViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
enum CxjToastViewConfigurator {
    static func viewWithConfig(
        _ config: CxjToastViewConfiguration,
        content: CxjToastContentView
    ) -> CxjToastView {
		let viewState: CxjToastContainerView.ViewState = CxjToastContainerViewStateConfigurator
			.state(for: config)
		let backgroundView: UIView = CxjToastContainerBackgroundViewFactory
			.backroundViewFor(background: config.background)
		
        let view = CxjToastContainerView(
			state: viewState,
            contentView: content,
			backgroundView: backgroundView
        )
        
        view.isUserInteractionEnabled = config.isUserInteractionEnabled
        
        return view
    }
}
