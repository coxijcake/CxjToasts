//
//  ToastViewConfigProvider+MinimalizedGlobalStatus.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 17/12/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
    final class MinimaliedGlobalStatusToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
        typealias Data = Template.MinimaliedGlobalStatusToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func config() -> Config {
            Config(
                contentInsets: .init(top: 8, left: 10, bottom: 8, right: 10),
                background: data.background,
                shadow: .disable,
                corners: .straight(mask: .none)
            )
        }
    }
}
