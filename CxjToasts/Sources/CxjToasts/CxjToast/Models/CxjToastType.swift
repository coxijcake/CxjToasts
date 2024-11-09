//
//  CxjToastType.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToastType {
	case templated(template: CxjToastTemplate)
	case custom(data: CustomToastData)
}

extension CxjToastType {
	public struct CustomToastData {
		let config: CxjToastConfiguration
		let viewConfig: CxjToastViewConfiguration
		let content: CxjToastContentView
		
		public init(
			config: CxjToastConfiguration,
			viewConfig: CxjToastViewConfiguration,
			content: CxjToastContentView
		) {
			self.config = config
			self.viewConfig = viewConfig
			self.content = content
		}
	}
}
