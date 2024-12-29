//
//  ToastContentConfigurator+CompactActionDescription.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

extension CxjTemplatedToastContentConfiguratorFactory {
    final class CompactActionDescriptionToastContentConfigurator: CxjTemplatedToastContentConfigurator {
        typealias Data = CxjToastTemplate.CompactActionDescriptionToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func content() -> any Content {
            let textConfig: CxjToastTextContentConfiguration = textConfigForData(data)
            
            return CxjInfoToastContentViewConfigurator.contentViewForType(
                .text(
                    config: textConfig
                )
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
