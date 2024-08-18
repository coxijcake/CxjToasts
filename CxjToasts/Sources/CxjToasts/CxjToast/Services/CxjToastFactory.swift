//
//  CxjToastFactory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
enum CxjToastFactory {
    static func toastFor(
        type: CxjToastType,
        content: CxjToastContentView
    ) -> CxjToastable {
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
            contentInsets: .zero,
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
                        min: 120,
                        max: 250
                    )
                ),
                placement: .top
            ),
            hidingMethods: [
                .swipe(direction: .top),
                .automatic(time: 3.0)
            ],
            presentAnimation: CxjToastConfiguration.Animation(
                type: .default,
                duration: 0.25
            ),
            dismissAnimation: CxjToastConfiguration.Animation(
                type: .default,
                duration: 0.25
            ),
            sourceView: keyWindow()! //TODO: - Remove force unwrap
        )
    }
}

//TODO: - Move to another place!!!
func keyWindow() -> UIWindow? {
    if #available(iOS 13.0, *) {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else {
                continue
            }
            if windowScene.windows.isEmpty {
                continue
            }
            guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                continue
            }
            return window
        }
        return nil
    } else {
        return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}
