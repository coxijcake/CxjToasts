//
//  CxjTemplatedToastConfigProviderFactory.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

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
		}
	}
}
