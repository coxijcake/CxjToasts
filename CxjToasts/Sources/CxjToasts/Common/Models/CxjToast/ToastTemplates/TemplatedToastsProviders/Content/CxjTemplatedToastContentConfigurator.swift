//
//  CxjToastContentConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 09/09/2024.
//

import UIKit

protocol CxjTemplatedToastContentConfigurator {
	typealias Content = CxjToastContentView
	
	typealias TitlesConfig = CxjTitledToastContentConfiguration.TitlesParams
	typealias PlainTitleConfig = TitlesConfig.PlainLabel
	
	func content() -> Content
}

