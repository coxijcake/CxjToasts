//
//  CxjToastViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
enum CxjToastViewFactory {
    static func createViewWith(
        config: CxjToastViewConfiguration,
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
        
        return view
    }
}
