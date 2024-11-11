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
			CxjNativeToastViewConfigProvider(data: data)
		case .bottomPrimary(data: let data):
			CxjBottomPrimaryToastViewConfigProvider(data: data)
		case .topStraight(data: let data):
			CxjTopStraightToastViewConfigProvider(data: data)
		}
	}
}
