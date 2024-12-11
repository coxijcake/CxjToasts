//
//  TopStraightToastContentConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

final class TopStraightToastContentConfigurator: CxjTemplatedToastContentConfigurator {
	typealias Data = CxjToastTemplate.TopStraightToastData
	
	let data: Data
	
	init(data: Data) {
		self.data = data
	}
	
	func content() -> any Content {
		let textConfig: CxjToastTextContentConfiguration = textConfigForData(data)
		
		if let icon = data.icon {
			return CxjInfoToastContentViewConfigurator.contentViewForType(
				.textWithIcon(
					iconConfig: .init(
						layout: .init(iconPlacement: .left, paddingToContent: 8),
						iconParams: .init(icon: icon, fixedSize: CGSize(width: 20, height: 20))
					),
					textConfig: textConfig
				)
			)
		} else {
			return CxjInfoToastContentViewConfigurator.contentViewForType(
				.text(config: textConfig)
			)
		}
	}
	
	private func textConfigForData(_ data: Data) -> CxjToastTextContentConfiguration {
		.title(labelConfig: .init(
			text: data.title,
			label: .init(
				numberOfLines: 1,
				textAligment: .left
			)
		)
		)
	}
}
