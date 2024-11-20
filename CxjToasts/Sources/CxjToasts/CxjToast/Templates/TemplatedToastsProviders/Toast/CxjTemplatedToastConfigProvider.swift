//
//  CxjTemplatedToastConfigProvider.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

protocol CxjTemplatedToastConfigProvider {
	typealias Config = CxjToastConfiguration
	
	func config() -> Config
}

extension CxjTemplatedToastConfigProvider {
	func defaultSourceView() -> UIView {
		UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
	}
}
