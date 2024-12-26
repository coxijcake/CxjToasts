//
//  ToastViewConfigProvider+BottomPrimary.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class BottomPrimaryToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.BottomPrimaryToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
                contentLayout: .fill(insets: .init(top: 10, left: 24, bottom: 10, right: 24)),
				background: data.background,
				shadow: shadow(),
                corners: .fixed(value: 44, mask: .all),
                isUserInteractionEnabled: true
			)
		}
		
		func shadow() -> Config.Shadow {
			if let shadow = data.shadow {
				return .enable(params: shadow)
			} else {
				return .disable
			}
		}
	}
}
