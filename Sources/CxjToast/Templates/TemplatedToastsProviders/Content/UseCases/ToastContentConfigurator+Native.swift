//
//  ToastContentConfigurator+Native.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastContentConfiguratorFactory {
	final class NativeToastContentConfigurator: CxjTemplatedToastContentConfigurator {
		typealias Data = CxjToastTemplate.NativeToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func content() -> any Content {
			let textConfig = textContentConfigForData(data)
			
			if let icon = data.icon {
				return CxjInfoToastContentViewConfigurator.contentViewForType(
					.textWithIcon(
						iconConfig: .init(
							layout: .init(iconPlacement: .left, paddingToContent: 10),
							iconParams: icon
						),
						textConfig: textConfig
					)
				)
			} else {
				return CxjInfoToastContentViewConfigurator.contentViewForType(.text(config: textConfig))
			}
		}
		
		private func textContentConfigForData(_ data: Data) -> CxjToastTextContentConfiguration {
			let titleLabelConfiguration = labelConfigForDataTextParams(data.title)
			
			if let subtitle = data.subtitle {
				let subtitleLabelConfiguration = labelConfigForDataTextParams(subtitle)
				return .withSubtitle(
					titleLabelConfig: titleLabelConfiguration,
					subtitleLabelConfig: subtitleLabelConfiguration,
					subtitleParams: .init(labelsPadding: 4)
				)
			} else {
				return .title(labelConfig: titleLabelConfiguration)
			}
		}
		
		private func labelConfigForDataTextParams(_ params: Data.Text) -> CxjLabelConfiguration {
			let textConfig = params
			let labelAttributes = labelAttributes()
			
			return .init(text: textConfig, label: labelAttributes)
		}
		
		private func labelAttributes() -> CxjLabelConfiguration.LabelAttributes {
			.init(numberOfLines: 1, textAligment: .center)
		}
	}
}
