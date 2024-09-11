//
//  CxjToastContentConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 09/09/2024.
//

import UIKit

public enum CxjTemplatedToastContentConfigurator {
	typealias Theme = CxjToastTheme
	typealias Content = CxjToastContentView
	
	static func configuredContent(for theme: Theme) -> Content {
		switch theme {
		case .native(let data):
			NativeContentConfigurator.configuredContent(for: data)
		}
	}
}
