//
//  ToastViewConfigProviderFactory+Provider.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

protocol CxjTemplatedToastViewConfigProvider {
	typealias Config = CxjToastViewConfiguration
	
	func config() -> Config
}
