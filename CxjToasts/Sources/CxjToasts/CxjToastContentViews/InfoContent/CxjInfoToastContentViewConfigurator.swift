//
//  CxjInfoToastContentViewConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 10/12/2024.
//

import UIKit

@MainActor
enum CxjInfoToastContentViewConfigurator {
	typealias ContentType = CxjToastContentConfiguration.InfoContentType
	typealias ContentView = CxjToastContentView
	
	static func contentViewForType(_ contentType: ContentType) -> ContentView {
		switch contentType {
		case .text(config: let config):
			return CxjToastTextContentViewConfigurator.viewWithConfig(config)
		case .textWithIcon(iconConfig: let iconConfig, textConfig: let textConfig):
			let textView = CxjToastTextContentViewConfigurator.viewWithConfig(textConfig)
			let contenttView = CxjIconWithTextToastContentViewConfigurator.viewWithConfig(iconConfig, infoContentView: textView)
			
			return contenttView
		}
	}
}
