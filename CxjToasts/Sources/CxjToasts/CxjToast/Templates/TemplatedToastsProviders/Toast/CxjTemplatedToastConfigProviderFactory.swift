//
//  CxjTemplatedToastConfigProviderFactory.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

@MainActor
enum CxjTemplatedToastConfigProviderFactory {
	typealias Template = CxjToastTemplate
	typealias Provider = CxjTemplatedToastConfigProvider
	
	static func configProviderFor(template: Template) -> Provider {
		switch template {
		case .native(data: let data):
			NativeToastConfigProvider(data: data)
		case .bottomPrimary(data: let data):
			BottomPrimaryToastConfigProvider(data: data)
		case .topStraight(data: let data):
			TopStraightToastConfigProvider(data: data)
        case .minimalizedGlobalStatus(data: let data):
            MinimaliedGlobalStatusToastConfigProvider(data: data)
        case .compactActionDescription(data: let data):
            CompactActionDescriptionConfigProvider(data: data)
		case .actionableEventToast(data: let data):
			ActionableEventToastConfigProvider(data: data)
		case .undoAction(data: let data):
			UndoActionConfigProvider(data: data)
		}
	}
}
