//
//  CxjToast+Factory.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

extension CxjToast {
    
    @MainActor
    enum Factory {
        typealias ViewConfiguration = CxjToastViewConfiguration
        
        static func createToast(
            type: ToastType,
            content: Content
        ) -> Toast {
            let view: ToastView = createToastView(
                for: type,
                content: content
            )
            
            let toastConfig: Configuration = config(
                for: type
            )
            
            return Toast(view: view, config: toastConfig)
        }
        
        //MARK: - ToastView
        private static func createToastView(
            for type: ToastType,
            content: Content
        ) -> ToastView {
            switch type {
            case .custom(_, let viewConfig):
                return CxjToastView(
                    config: viewConfig,
                    contentView: content
                )
            case .native:
                let viewConfig = nativeViewConfiguration()
                let config = nativeConfig()
                return CxjToastView(
                    config: viewConfig,
                    contentView: content
                )
            }
        }
        
        //MARK: - Configuration
        private static func config(
            for type: ToastType
        ) -> Configuration {
            switch type {
            case .custom(let config, _):
                return config
            case .native:
                return nativeConfig()
            }
        }
        
        //MARK: - Native configuration
        private static func nativeViewConfiguration() -> ViewConfiguration {
            ViewConfiguration(
                contentInsets: .zero,
                colors: ViewConfiguration.Colors(
                    background: .white
                ),
                shadow: .enable(
                    params: ViewConfiguration.Shadow.Params(
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
        private static func nativeConfig() -> Configuration {
            return Configuration(
                constraints: Configuration.Constraints(
                    width: Configuration.Constraints.ConstraintValues(
                        min: UIScreen.main.bounds.size.width - 100,
                        max: UIScreen.main.bounds.size.width - 16 * 2
                    ),
                    height: Configuration.Constraints.ConstraintValues(
                        min: 120,
                        max: 250
                    )
                ),
                placement: Configuration.Placement.top,
                hidingMethods: [
                    .swipe(direction: .top),
                    .automatic(time: 3.0)
                ],
                presentAnimation: Configuration.Animation(
                    type: .default,
                    duration: 0.25
                ),
                dismissAnimation: Configuration.Animation(
                    type: .default,
                    duration: 0.25
                )
            )
        }
    }
}
