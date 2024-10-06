//
//  CxjToastViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

enum CxjToastViewFactory {
    static func createViewWith(
        config: CxjToastViewConfiguration,
        content: CxjToastContentView
    ) -> CxjToastView {
		let viewState: CxjToastContainerView.ViewState = CxjToastContainerViewStateConfigurator
			.state(for: config)
		
        let view = CxjToastContainerView(
			state: viewState,
            contentView: content
        )
        
        return view
    }
}
