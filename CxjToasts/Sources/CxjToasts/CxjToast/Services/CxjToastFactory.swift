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
        CxjToastViewConfiguration(
			contentInsets: .init(
				top: 0,
				left: 16,
				bottom: 0,
				right: 16
			),
            colors: CxjToastViewConfiguration.Colors(
                background: .white
            ),
            shadow: .enable(
                params: CxjToastViewConfiguration.Shadow.Params(
                    offset: CGSize(width: 0, height: 4),
                    color: UIColor.black.withAlphaComponent(0.18),
                    opacity: 1,
                    radius: 10
                )
            ),
            cornerRadius: 10
        )
    }
    
    //MARK: - Native Config
    static func nativeConfig() -> CxjToastConfiguration {
        return CxjToastConfiguration(
            layout: CxjToastConfiguration.Layout(
                constraints: CxjToastConfiguration.Constraints(
                    width: CxjToastConfiguration.Constraints.ConstraintValues(
                        min: UIScreen.main.bounds.size.width * 0.65,
                        max: UIScreen.main.bounds.size.width - 16 * 2
                    ),
                    height: CxjToastConfiguration.Constraints.ConstraintValues(
                        min: 60,
                        max: 250
                    )
                ),
                placement: .top(vericalOffset: 20)
//				placement: .bottom(verticalOffset: 20)
//				placement: .center
            ),
            hidingMethods: [
                .swipe(direction: .top),
				.tap,
                .automatic(time: 3.0)
			],
			animations: CxjToastConfiguration.Animations(
				present: CxjToastConfiguration.Animations.AnimationConfig(
					type: .default,
                    animation: .nativeToastPresenting
//					animation: .testLong
				),
				dismiss: CxjToastConfiguration.Animations.AnimationConfig(
					type: .default,
                    animation: .nativeToastDismissing
//					animation: .testLong
				)
			),
			sourceView: UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
        )
    }
}

fileprivate extension CxjAnimation {
	static let testLong = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 1.0,
			delay: .zero,
			options: [.curveLinear, .allowUserInteraction],
			animations: animations,
			completion: completion
		)
	}
	
	static let nativeToastPresenting = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 1.0,
			delay: .zero,
			usingSpringWithDamping: 0.65,
			initialSpringVelocity: 10.0,
			options: [.curveEaseOut, .allowUserInteraction],
			animations: animations,
			completion: completion
		)
	}
	
	static let nativeToastDismissing = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 0.25,
			delay: .zero,
			options: [.curveEaseIn],
			animations: animations,
			completion: completion
		)
	}
}
