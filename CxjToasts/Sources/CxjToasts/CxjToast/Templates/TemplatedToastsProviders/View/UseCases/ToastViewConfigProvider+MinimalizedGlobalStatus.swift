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
                contentLayout: .constraints(anchors: [
                    .bottom(value: .equal(value: .zero)),
                    .centerX(value: .equal(value: .zero)),
                    .left(value: .greaterOrEqual(value: 16)),
                    .right(value: .lessOrEqual(value: -16))
                ]),
                background: data.background,
                shadow: .disable,
                corners: .straight(mask: .none)
            )
        }
    }
}
