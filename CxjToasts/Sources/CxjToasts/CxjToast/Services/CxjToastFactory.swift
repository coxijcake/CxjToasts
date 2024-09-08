//
//  CxjToastFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

enum CxjToastFactory {
    static func toastFor(
        type: CxjToastType,
        content: CxjToastContentView
    ) -> CxjToast {
        let view: CxjToastView = createToastView(
            for: type,
            content: content
        )
        
        let toastConfig: CxjToastConfiguration = config(
            for: type
        )
        
        return CxjToast(view: view, config: toastConfig)
    }
}

private extension CxjToastFactory {
    //MARK: - ToastView
    static func createToastView(
        for type: CxjToastType,
        content: CxjToastContentView
    ) -> CxjToastView {
        switch type {
        case .custom(_, let viewConfig):
            return CxjToastViewFactory.createViewWith(
                config: viewConfig,
                content: content
            )
        case .native:
            let viewConfig = nativeViewConfiguration()
            return CxjToastViewFactory.createViewWith(
                config: viewConfig,
                content: content
            )
        }
    }
    
    //MARK: - Configuration
    static func config(
        for type: CxjToastType
    ) -> CxjToastConfiguration {
        switch type {
        case .custom(let config, _):
            return config
        case .native:
            return nativeConfig()
        }
    }
    
    //MARK: - Native configuration
    static func nativeViewConfiguration() -> CxjToastViewConfiguration {
		CxjToastTheme.native.toastViewConfig
    }
    
    //MARK: - Native Config
    static func nativeConfig() -> CxjToastConfiguration {
		CxjToastTheme.native.toastConfig
    }
}
