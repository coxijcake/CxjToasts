//
//  CxjTemplatedToastConfigProvider.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import Foundation

protocol CxjTemplatedToastConfigProvider {
	typealias Config = CxjToastConfiguration
	
	func config() -> Config
}
