//
//  CustomToastFactory+SidePresenting.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit
import CxjToasts

extension CustomToastFactory {
    @MainActor
    enum SidePresentingToastDataConfigurator {
        static func toastData(withSourceView sourceView: UIView) -> ToastData {
            ToastData(
                config: config(withSourceView: sourceView),
                viewConfig: viewConfig(),
                content: contentView()
            )
        }
        
        //MARK: - Config
        private static func config(withSourceView sourceView: UIView) -> ToastConfig {
            return ToastConfig(
                typeId: "side_presenting_toast_type",
                sourceView: sourceView,
                sourceBackground: nil,
                layout: layoutInsideSourceView(sourceView),
                dismissMethods: dismissMethods(),
                keyboardHandling: .ignore,
                animations: animations(sourceView: sourceView),
                spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
            )
        }
        
        private static func layoutInsideSourceView(_ sourceView: UIView) -> ToastConfig.Layout {
            ToastConfig.Layout(
                constraints: .init(
                    width: .init(
                        min: sourceView.bounds.size.width * 0.75,
                        max: sourceView.bounds.size.width * 0.95
                    ),
                    height: .init(
                        min: 40,
                        max: 150
                    )
                ),
                placement: .top(params: .init(offset: 20, includingSafeArea: true))
            )
        }
        
        private static func dismissMethods() -> Set<ToastConfig.DismissMethod> {
            [
                .swipe(direction: .right),
                .tap(actionCompletion: nil),
                .automatic(time: 3.0)
            ]
        }
        
        private static func animations(sourceView: UIView) -> ToastConfig.Animations {
            ToastConfig.Animations(
                present: presentAnimation(sourceView: sourceView),
                dismiss: dismissAnimation(sourceView: sourceView)
            )
        }
        
        private static func presentAnimation(sourceView: UIView) -> ToastConfig.Animation {
            ToastConfig.Animation(
                animation: .defaultSpring,
                behaviour: .custom(
                    changes: [
                        .translation(type: .custom(value: .init(x: -sourceView.bounds.size.width * 0.5, y: .zero))),
                        .scale(value: .init(x: 0.5, y: 1.0)),
                        .alpha(intensity: .zero)
                    ]
                )
            )
        }
        
        private static func dismissAnimation(sourceView: UIView) -> ToastConfig.Animation {
            ToastConfig.Animation(
                animation: .defaultSpring,
                behaviour: .custom(
                    changes: [
                        .translation(type: .custom(value: .init(x: sourceView.bounds.size.width * 0.5, y: .zero))),
                        .scale(value: .init(x: 0.5, y: 1.0)),
                        .alpha(intensity: .zero)
                    ]
                )
            )
        }
        
        private static func spamProtection() -> ToastConfig.SpamProtection {
            .off
        }
        
        private static func coexistencePolicy() -> ToastConfig.ToastCoexistencePolicy {
            .init(
                handling: .dismiss,
                comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .or)
            )
        }
        
        //MARK: - ViewConfig
        private static func viewConfig() -> CxjToastViewConfiguration {
            CxjToastViewConfiguration(
                contentLayout: .fill(insets: .init(top: 20, left: 16, bottom: 20, right: 16)),
                background: .gradient(
                    params: .init(
                        colors: [
                            .black.withAlphaComponent(0.9),
                            .black.withAlphaComponent(0.5),
                            .black.withAlphaComponent(0.1)
                        ],
                        locations: [0, 0.5, 1],
                        direction: .init(startPoint: .init(x: 0.1, y: 0.25),
                                         endPoint: .init(x: 0.8, y: 0.75))
                    )
                ),
                shadow: .disable,
                corners: .fixed(value: 16, mask: .all),
                isUserInteractionEnabled: true
            )
        }
        
        //MARK: - Content
        private static func contentView() -> CxjToastContentView {
            CxjToastContentViewFactory.createContentViewWith(
                config: .info(
                    type: .text(
                        config: .title(
                            labelConfig: .init(
                                text: .plain(
                                    string: "Some test title",
                                    attributes: .init(
                                        textColor: .white,
                                        font: .systemFont(ofSize: 15, weight: .bold)
                                    )
                                ),
                                label: .init(numberOfLines: 1, textAligment: .center)
                            )
                        )
                    )
                )
            )
        }
    }
}
