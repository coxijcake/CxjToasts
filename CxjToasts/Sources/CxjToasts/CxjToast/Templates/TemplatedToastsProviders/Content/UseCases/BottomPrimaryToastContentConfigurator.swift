//
//  BottomPrimaryToastContentConfigurator.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

@MainActor
final class BottomPrimaryToastContentConfigurator: CxjTemplatedToastContentConfigurator {
	typealias Data = CxjToastTemplate.BottomPrimaryToastData
	
	let data: Data
	
	init(data: Data) {
		self.data = data
	}
	
	func content() -> Content {
		let textConfig: CxjToastTextContentConfiguration = textConfigForData(data)
		
		if let icon = data.icon {
			return CxjInfoToastContentViewConfigurator.contentViewForType(
				.textWithIcon(
					iconConfig: .init(
						layout: .init(iconPlacement: .top, paddingToContent: 10),
						iconParams: icon
					),
					textConfig: textConfig
				)
			)
		} else {
			return CxjToastTextContentViewConfigurator.viewWithConfig(textConfig)
		}
	}
	
	private func textConfigForData(_ data: Data) -> CxjToastTextContentConfiguration {
		if let subtitle = data.subtitle {
			return .withSubtitle(
				titleLabelConfig: data.title,
				subtitleLabelConfig: subtitle,
				subtitleParams: .init(labelsPadding: 4)
			)
		} else {
			return .title(labelConfig: data.title)
		}
	}

}
