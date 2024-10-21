//
//  NativeToastContentConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

final class NativeToastContentConfigurator: CxjTemplatedToastContentConfigurator {
	typealias Data = CxjToastTemplate.NativeToastData
	
	let data: Data
	
	init(data: Data) {
		self.data = data
	}
	
	func content() -> Content {
		let titlesConfig: TitlesConfig = titlesConfig(for: data)
		
		if let icon = data.icon {
			return CxjToastContentViewFactory.createContentViewWith(
				config: CxjToastContentConfiguration.iconed(
					config: CxjIconedToastContentConfiguration(
						params: .init(
							iconPlacement: .left,
							paddingToTitle: 10
						),
						iconParams: CxjIconedToastContentConfiguration.IconParams(
							icon: icon,
							fixedSize: CGSize(width: 40, height: 40)
						)
					),
					titlesConfig: .init(
						layout: .init(labelsPadding: 4),
						titles: titlesConfig
					)
				)
			)
		} else {
			return CxjToastContentViewFactory.createContentViewWith(
				config: .titled(
					config: .init(
						layout: .init(labelsPadding: 4),
						titles: titlesConfig
					)
				)
			)
		}
	}
	
	private  func titlesConfig(for data: Data) -> TitlesConfig {
		TitlesConfig.plain(
			config: .init(
				title: titleConfig(for: data),
				subtitle: subtitleConfig(for: data)
			)
		)
	}
	
	private  func titleConfig(for data: Data) -> PlainTitleConfig {
		PlainTitleConfig(
			text: data.title,
			labelParams: .init(
				textColor: .black,
				font: .systemFont(ofSize: 14, weight: .bold),
				numberOfLines: 1,
				textAligment: .center
			)
		)
	}
	
	private func subtitleConfig(for data: Data) -> PlainTitleConfig? {
		guard let subtitle = data.subtitle else { return nil }
		
		return PlainTitleConfig(
			text: subtitle,
			labelParams: TitlesConfig.LabelParams(
				textColor: .black,
				font: .systemFont(ofSize: 13, weight: .semibold),
				numberOfLines: 1,
				textAligment: .center
			)
		)
	}
}
