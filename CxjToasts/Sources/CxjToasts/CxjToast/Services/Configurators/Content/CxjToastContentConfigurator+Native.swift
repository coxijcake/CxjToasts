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
		typealias TitlesConfig = CxjToastTitlesConfiguration
		typealias SubtitleConfig = TitlesConfig.PlainLabel
		
		static func configuredContent(for data: Data) -> Content {
			let titlesConfig: TitlesConfig = titlesConfig(for: data)
			
			if let icon = data.icon {
				return CxjToastContentViewFactory.createContentViewWith(
					config: CxjToastContentConfiguration.iconed(
						config: CxjIconedToastConfiguration(
							params: CxjIconedToastConfiguration.IconParams(
								icon: icon,
								tintColor: nil
							)
						),
						titlesConfig: titlesConfig
					)
				)
			} else {
				return CxjToastContentViewFactory.createContentViewWith(
					config: .titled(
						config: titlesConfig
					)
				)
			}
		}
		
		private static func titlesConfig(for data: Data) -> TitlesConfig {
			CxjToastTitlesConfiguration.plain(
				config: CxjToastTitlesConfiguration.Plain(
					title: CxjToastTitlesConfiguration.PlainLabel(
						text: data.title,
						labelParams: CxjToastTitlesConfiguration.LabelParams(
							numberOfLines: 1,
							textAligment: textAligment(for: data)
						)
					),
					subtitle: subtitleConfig(for: data)
				)
			)
		}
		
		private static func subtitleConfig(for data: Data) -> SubtitleConfig? {
			guard let subtitle = data.subtitle else { return nil }
			
			return SubtitleConfig(
				text: subtitle,
				labelParams: CxjToastTitlesConfiguration.LabelParams(
					numberOfLines: 1,
					textAligment: textAligment(for: data)
				)
			)
		}
		
		private static func textAligment(for data: Data) -> NSTextAlignment {
			.center
		}
	}
}
