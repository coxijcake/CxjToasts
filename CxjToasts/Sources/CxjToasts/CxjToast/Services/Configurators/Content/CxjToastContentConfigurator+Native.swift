//
//  CxjToastContentConfigurator+Native.swift
//
//
//  Created by Nikita Begletskiy on 11/09/2024.
//

import UIKit

extension CxjTemplatedToastContentConfigurator {
	enum NativeContentConfigurator {
		typealias Data = CxjToastTheme.NativeToastData
		typealias TitlesConfig = CxjTitledToastContentConfiguration.TitlesParams
		typealias PlainTitleConfig = TitlesConfig.PlainLabel
		
		static func configuredContent(for data: Data) -> Content {
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
		
		private static func titlesConfig(for data: Data) -> TitlesConfig {
			TitlesConfig.plain(
				config: .init(
					title: titleConfig(for: data),
					subtitle: subtitleConfig(for: data)
				)
			)
		}
		
		private static func titleConfig(for data: Data) -> PlainTitleConfig {
			PlainTitleConfig(
				text: data.title,
				labelParams: .init(
					numberOfLines: 1,
					textAligment: .center
				)
			)
		}
		
		private static func subtitleConfig(for data: Data) -> PlainTitleConfig? {
			guard let subtitle = data.subtitle else { return nil }
			
			return PlainTitleConfig(
				text: subtitle,
				labelParams: TitlesConfig.LabelParams(
					numberOfLines: 1,
					textAligment: .center
				)
			)
		}
	}
}
