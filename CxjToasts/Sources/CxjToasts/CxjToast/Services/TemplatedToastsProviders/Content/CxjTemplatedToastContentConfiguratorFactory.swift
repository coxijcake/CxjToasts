//
//  CxjTemplatedToastContentConfiguratorFactory.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

enum CxjTemplatedToastContentConfiguratorFactory {
	typealias Template = CxjToastTemplate
	
	static func configuratorFor(template: Template) -> CxjTemplatedToastContentConfigurator {
		switch template {
		case .native(let data):
			NativeToastContentConfigurator(data: data)
		case .bottomPrimary(data: let data):
			BottomPrimaryToastContentConfigurator(data: data)
		}
	}
}
