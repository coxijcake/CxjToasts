//
//  CxjToastViewFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

enum CxjToastViewFactory {
    static func createViewWith(
        config: CxjToastViewConfiguration,
        content: CxjToastContentView
    ) -> CxjToastView {
        let view = CxjToastView(
            config: config,
            contentView: content
        )
        
        return view
    }
}
