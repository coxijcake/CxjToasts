//
//  CxjToastContentConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 09/09/2024.
//

import UIKit

@MainActor
protocol CxjTemplatedToastContentConfigurator {
	typealias Content = CxjToastContentView
	typealias TitlesConfig = CxjToastTextContentConfiguration
	
	func content() -> Content
}

