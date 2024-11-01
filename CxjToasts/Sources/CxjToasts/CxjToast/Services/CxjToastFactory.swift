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
		
		let sourceBackground: CxjToastSourceBackground? = CxjToastSourceBackgroundFactory
			.backgroundForTheme(config.sourceBackground?.theme)
		
		let animator: CxjToastAnimator = CxjToastAnimator(
			toastView: view,
			sourceView: config.sourceView,
			sourceBackground: sourceBackground,
			config: config
		)
		
		let presenter: CxjToastPresenter = CxjToastPresenter(
			config: config,
			toastView: view,
			sourceBackgroundView: sourceBackground,
			animator: animator
		)
		
		let dismisser: CxjToastDismisser = CxjToastDismisser(
			toastId: toastId,
			toastView: view,
			sourceBackgroundView: sourceBackground,
			config: config,
			animator: animator,
			delegate: CxjToastsCoordinator.shared
		)
		
		let toast: CxjToast = CxjToast(
			id: toastId,
			view: view,
			sourceBackground: sourceBackground,
			config: config,
			presenter: presenter,
			dismisser: dismisser
		)
		
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
