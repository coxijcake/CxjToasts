//
//  CxjToastContentViewFactory.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

public enum CxjToastContentViewFactory {
    public static func createContentViewWith(config: CxjToastContentConfiguration) -> CxjToastContentView {
        switch config {
        case .iconed(config: let config, titlesConfig: let titlesConfig):
            let view: CxjIconedToastContentView = CxjIconedToastContentView()
            view.configureWith(config: config, titlesConfig: titlesConfig)
            
            return view
        case .titled(config: let config):
            let view: CxjTitledToastContentView = CxjTitledToastContentView()
            view.configureWith(configuration: config)
            
            return view
		case .undoAction(config: let config):
			return CxjUndoActionToastContentViewConfigurator.configuredContentViewWithConfig(config)
        case .custom(contentView: let contentView):
            return contentView
        }
    }
}
