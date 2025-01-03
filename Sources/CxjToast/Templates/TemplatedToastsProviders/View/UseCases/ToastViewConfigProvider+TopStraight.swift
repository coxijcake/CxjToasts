//
//  ToastViewConfigProvider+TopStraight.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class TopStraightToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.TopStraightToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
                contentLayout: .fill(insets: .init(top: 10, left: 12, bottom: 10, right: 12)),
				background: data.background,
                shadow: data.shadow,
                corners: .straight(mask: .none),
                isUserInteractionEnabled: true
			)
		}
	}
}
