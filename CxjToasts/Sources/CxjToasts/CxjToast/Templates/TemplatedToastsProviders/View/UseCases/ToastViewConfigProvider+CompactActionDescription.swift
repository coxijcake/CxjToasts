//
//  ToastViewConfigProvider+CompactActionDescription.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
    final class CompactActionDescriptionToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
        typealias Data = Template.CompactActionDescriptionToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func config() -> Config {
            Config(
                contentLayout: .fill(insets: .init(top: 12, left: 14, bottom: 12, right: 14)),
                background: .colorized(color: .black),
                shadow: .enable(
                    params: .init(
                        offset: .init(width: 0, height: 2),
                        color: .black.withAlphaComponent(0.75),
                        opacity: 1.0,
                        radius: 6
                    )
                ),
                corners: .fixed(value: 6, mask: .all)
            )
        }
    }
}
