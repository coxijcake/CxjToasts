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
		if let iconedConfig = iconedConfig(for: data) {
			return CxjToastContentViewFactory
				.createContentViewWith(config: iconedConfig)
		} else {
			let titledContentConfig = titledContentConfigFor(data: data)
			return CxjToastContentViewFactory
				.createContentViewWith(config: .titled(config: titledContentConfig))
		}
	}
	
	private func iconedConfig(for data: Data) -> CxjToastContentConfiguration? {
		guard let icon = data.icon else { return nil }
		
		return .iconed(
			config: CxjIconedToastContentConfiguration(
				params: CxjIconedToastContentConfiguration.LayoutParams(
					iconPlacement: .top,
					paddingToTitle: 10
				),
				iconParams: CxjIconedToastContentConfiguration.IconParams(
					icon: icon,
					fixedSize: CGSize(width: 40, height: 40)
				)
			),
			titlesConfig: titledContentConfigFor(data: data)
		)
	}
	
	private func titledContentConfigFor(data: Data) -> CxjTitledToastContentConfiguration {
		.init(
			layout: CxjTitledToastContentConfiguration.LayoutParams(
				labelsPadding: 4
			),
			titles: titlesConfigFor(data: data)
		)
	}
	
	private func titlesConfigFor(data: Data) -> TitlesConfig {
		TitlesConfig.plain(
			config: CxjTitledToastContentConfiguration.TitlesParams.Plain(
				title: titleConfigFor(data: data),
				subtitle: subtitleConfigFor(data: data)
			)
		)
	}
	
	private func titleConfigFor(data: Data) -> PlainTitleConfig {
		let title = data.title
		
		return PlainTitleConfig(
			text: title.text,
			labelParams: .init(
				textColor: title.textColor,
				font: title.font,
				numberOfLines: title.numberOfLines,
				textAligment: .center
			)
		)
	}
	
	private func subtitleConfigFor(data: Data) -> PlainTitleConfig? {
		guard let subtitle = data.subtitle else { return nil }
		
		return PlainTitleConfig(
			text: subtitle.text,
			labelParams: .init(
				textColor: subtitle.textColor,
				font: subtitle.font,
				numberOfLines: subtitle.numberOfLines,
				textAligment: .center
			)
		)
	}
}
