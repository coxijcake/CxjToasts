//
//  ToastContentConfigurator+GlobalMinimalizedStatus.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 17/12/2024.
//

import UIKit

extension CxjTemplatedToastContentConfiguratorFactory {
    final class GlobalMinimalizedStatusToastContentConfigurator: CxjTemplatedToastContentConfigurator {
        typealias Data = CxjToastTemplate.MinimaliedGlobalStatusToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func content() -> any Content {
            let textConfig: CxjToastTextContentConfiguration = textConfigForData(data)
            
            if let iconConfig = iconConfigForData(data) {
                return CxjInfoToastContentViewConfigurator.contentViewForType(
                    .textWithIcon(
                        iconConfig: iconConfig,
                        textConfig: textConfig
                    )
                )
            } else {
                return CxjInfoToastContentViewConfigurator.contentViewForType(
                    .text(config: textConfig)
                )
            }
        }
        
        private func iconConfigForData(_ data: Data) -> CxjIconedToastContentConfiguration? {
            guard let icon = data.icon else { return nil }
            
            return .init(
                layout: .init(iconPlacement: .left, paddingToContent: 8),
                iconParams: icon
            )
        }
        
        private func textConfigForData(_ data: Data) -> CxjToastTextContentConfiguration {
            .title(
                labelConfig: .init(
                    text: data.title,
                    label: .init(
                        numberOfLines: 1,
                        textAligment: .center
                    )
                )
            )
        }
    }
}
