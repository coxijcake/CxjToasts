//
//  CxjTemplatedToastViewConfigProviderFactory.swift
//
//
//  Created by Nikita Begletskiy on 08/09/2024.
//

import Foundation

enum CxjTemplatedToastViewConfigProviderFactory {
	typealias Template = CxjToastTemplate
	typealias Provider = CxjTemplatedToastViewConfigProvider
	
	static func configProviderFor(template: Template) -> Provider {
		switch template {
		case .native(let data):
			NativeToastViewConfigProvider(data: data)
		case .bottomPrimary(data: let data):
			BottomPrimaryToastViewConfigProvider(data: data)
		case .topStraight(data: let data):
			TopStraightToastViewConfigProvider(data: data)
        case .minimalizedGlobalStatus(data: let data):
            MinimaliedGlobalStatusToastViewConfigProvider(data: data)
        case .compactActionDescription(data: let data):
            CompactActionDescriptionToastViewConfigProvider(data: data)
		case .compactAction(data: let data):
			CompactActionToastViewConfigProvider(data: data)
		case .undoAction(data: let data):
			UndoActionToastViewConfigProvider(data: data)
		}
	}
}
