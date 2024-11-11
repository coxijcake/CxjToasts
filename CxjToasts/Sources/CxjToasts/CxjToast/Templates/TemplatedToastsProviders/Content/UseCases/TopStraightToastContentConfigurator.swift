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
	
	func content() -> Content {
		if let iconedConfig = iconedConfig(for: data) {
			return CxjToastContentViewFactory
				.createContentViewWith(config: iconedConfig)
		} else {
			let titledConfig = titledContentConfigFor(data: data)
			return CxjToastContentViewFactory
				.createContentViewWith(config: .titled(config: titledConfig))
		}
	}
	
	private func iconedConfig(for data: Data) -> CxjToastContentConfiguration? {
		guard let icon = data.icon else { return nil }
		
		return .iconed(
			config: CxjIconedToastContentConfiguration(
				params: CxjIconedToastContentConfiguration.LayoutParams(
					iconPlacement: .left,
					paddingToTitle: 8
				),
				iconParams: CxjIconedToastContentConfiguration.IconParams(
					icon: icon,
					fixedSize: CGSize(width: 20, height: 20)
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
				subtitle: nil
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
				numberOfLines: 1,
				textAligment: .left
			)
		)
	}
}
