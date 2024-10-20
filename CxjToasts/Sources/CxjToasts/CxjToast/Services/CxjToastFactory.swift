//
//  CxjToastFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

public enum CxjToastFactory {
    static func toastFor(
        type: CxjToastType
    ) -> CxjToast {
		let toastId: UUID = UUID()
		
        let view: CxjToastView = createToastView(
            for: type
        )
        
        let config: CxjToastConfiguration = config(
            for: type
        )
		
		let animator: CxjToastAnimator = CxjToastAnimator(
			toastView: view,
			config: config
		)
		
		let presenter: CxjToastPresenter = CxjToastPresenter(
			config: config,
			toastView: view,
			animator: animator
		)
		
		let dismisser: CxjToastDismisser = CxjToastDismisser(
			toastId: toastId,
			toastView: view,
			config: config,
			animator: animator
		)
		
		let toast: CxjToast = CxjToast(
			id: toastId,
			view: view,
			config: config,
			presenter: presenter,
			dismisser: dismisser
		)
		
		dismisser.delegate = toast
		
		return toast
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
