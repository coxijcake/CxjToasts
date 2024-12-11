//
//  CxjToastContentViewFactory.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
public enum CxjToastContentViewFactory {
    public static func createContentViewWith(config: CxjToastContentConfiguration) -> CxjToastContentView {
        switch config {
		case .info(type: let type):
			return CxjInfoToastContentViewConfigurator.contentViewForType(type)
		case .action(config: let config, infoContent: let infoContent):
			let infoContentView = CxjInfoToastContentViewConfigurator.contentViewForType(infoContent)
			return CxjActionToastContentViewConfigurator.createViewWithConfig(config, infoContentView: infoContentView)
		case .undoAction(config: let config):
			return CxjUndoActionToastContentViewConfigurator.configuredContentViewWithConfig(config)
        case .custom(contentView: let contentView):
            return contentView
		}
    }
}
