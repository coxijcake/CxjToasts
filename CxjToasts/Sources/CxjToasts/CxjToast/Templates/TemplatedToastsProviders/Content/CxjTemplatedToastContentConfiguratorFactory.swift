//
//  CxjTemplatedToastContentConfiguratorFactory.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

@MainActor
enum CxjTemplatedToastContentConfiguratorFactory {
	typealias Template = CxjToastTemplate
	
	static func configuratorFor(template: Template, toastId: UUID) -> CxjTemplatedToastContentConfigurator {
		switch template {
		case .native(let data):
			NativeToastContentConfigurator(data: data)
		case .bottomPrimary(data: let data):
			BottomPrimaryToastContentConfigurator(data: data)
		case .topStraight(data: let data):
			TopStraightToastContentConfigurator(data: data)
		case .compactAction(data: let data):
			CompactActionToastContentConfigurator(data: data, toastId: toastId)
		case .undoAction(data: let data):
			UndoActionToastContentConfigurator(data: data, toastId: toastId)
		}
	}
}
