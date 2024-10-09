//
//  ToastViewConfigProvider+BottomPrimary.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class CxjBottomPrimaryToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.BottomPrimaryToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
				contentInsets: .init(top: 10, left: 24, bottom: 10, right: 24),
				colors: .init(background: data.backgroundColor),
				shadow: shadow(),
				corners: .rounded(value: 44, mask: .all)
			)
		}
		
		func shadow() -> Config.Shadow {
			if let shadowColor = data.shadowColor {
				return .enable(
					params: .init(
						offset: .init(width: 0, height: 4),
						color: shadowColor,
						opacity: 1.0,
						radius: 10
					)
				)
			} else {
				return .disable
			}
		}
	}
}
