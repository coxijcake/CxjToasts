//
//  CxjToastFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

enum CxjToastFactory {
    static func toastFor(
        type: CxjToastType
    ) -> CxjToast {
        let view: CxjToastView = createToastView(
            for: type
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
        for type: CxjToastType
    ) -> CxjToastView {
        switch type {
        case .custom(_, let viewConfig, let content):
            return CxjToastViewFactory.createViewWith(
                config: viewConfig,
                content: content
            )
        case .templated(template: let template):
			let viewConfig = CxjTemplatedToastViewConfigProviderFactory
				.configProviderFor(template: template)
				.config()
			
			let content = CxjTemplatedToastContentConfiguratorFactory
				.configuratorFor(template: template)
				.content()
			
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
        case .custom(let config, _, _):
            return config
		case .templated(template: let template):
			return CxjTemplatedToastConfigProviderFactory
				.configProviderFor(template: template)
				.config()
        }
    }
}
