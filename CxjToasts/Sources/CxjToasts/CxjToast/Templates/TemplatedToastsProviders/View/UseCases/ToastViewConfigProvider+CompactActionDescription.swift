//
//  ToastViewConfigProvider+CompactActionDescription.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
    final class CompactActionDescriptionToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
        typealias Data = Template.CompactActionDescriptionToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func config() -> Config {
            Config(
                contentLayout: .fill(insets: .init(top: 12, left: 14, bottom: 12, right: 14)),
				background: data.background,
				shadow: shadowForData(data.shadow),
                corners: .fixed(value: 6, mask: .all),
                isUserInteractionEnabled: true
            )
        }
		
		func shadowForData(_ data: Data.Shadow?) -> CxjToastViewConfiguration.Shadow {
			if let shadowParams = data {
				return .enable(params: shadowParams)
			} else {
				return .disable
			}
		}
    }
}
