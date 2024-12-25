//
//  CustomToastFactory+gradient.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit
import CxjToasts

extension CustomToastFactory {
    @MainActor
    enum BottomGradientWithBlurredBackgroundToastDataConfigurator {
        static func toastData(withSoureView soureView: UIView) -> ToastData {
            ToastData(
                config: config(withSourceView: soureView),
                viewConfig: viewConfig(),
                content: contentView()
            )
        }
        
        //MARK: - Config
        private static func config(withSourceView sourceView: UIView) -> ToastConfig {
            return ToastConfig(
                typeId: "bottom_gradient_with_blurred_background_toast_type",
                sourceView: sourceView,
                sourceBackground: sourceBackground(),
                layout: layout(inSourceView: sourceView),
                dismissMethods: dismissMethods(),
                keyboardHandling: .moveToastUpperKeyboard(additionalOffset: 10),
                animations: animations(),
				hapticFeeback: .uiImpact(style: .heavy),
                spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
            )
        }
        
        private static func sourceBackground() -> ToastConfig.SourceBackground? {
            let darkBlurredBackground: CxjToastConfiguration.SourceBackground = .init(
                theme: .blurred(effect: .init(style: .dark)),
                interaction: .enabled(
                    action: .init(
                        touchEvent: .touchUpInside,
                        handling: .custom(completion: { toast in
                            print("custom background view action for toat with id \(toast.id)")
                            Task { @MainActor in
                                CxjToastsCoordinator.shared.dismissAll(animated: true)
                            }
                        })
                    )
                )
            )
            
            return darkBlurredBackground
        }
        
        private static func layout(inSourceView sourceView: UIView) -> ToastConfig.Layout {
            ToastConfig.Layout(
                constraints: CxjToastConfiguration.Constraints(
                    width: CxjToastConfiguration.Constraints.Values(
                        min: sourceView.bounds.size.width * 0.75,
                        max: sourceView.bounds.size.width
                    ),
                    height: CxjToastConfiguration.Constraints.Values(
                        min: 40,
                        max: 150
                    )
                ),
                placement: .bottom(params: .init(offset: 100, includingSafeArea: true))
            )
        }
        
        private static func dismissMethods() -> Set<ToastConfig.DismissMethod> {
            [
                .swipe(direction: .bottom),
                .tap(actionCompletion: nil),
                .automatic(time: 3.0)
            ]
        }
        
        private static func animations() -> ToastConfig.Animations {
            ToastConfig.Animations(
                present: presentAnimation(),
                dismiss: dismissAnimation()
            )
        }
        
        private static func presentAnimation() -> ToastConfig.Animation {
            ToastConfig.Animation(
                animation: .defaultSpring,
                behaviour: .custom(changes: [.translation(type: .outOfSourceViewVerticaly)])
            )
        }
        
        private static func dismissAnimation() -> ToastConfig.Animation {
            ToastConfig.Animation(
                animation: .defaultSpring,
                behaviour: .custom(changes: [.alpha(intensity: .zero), .scale(value: .init(x: 0.9, y: 0.75))])
            )
        }
        
        private static func spamProtection() -> ToastConfig.SpamProtection {
            .off
        }
        
        private static func coexistencePolicy() -> ToastConfig.ToastCoexistencePolicy {
            .init(handling: .dismiss, comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .or))
        }
        
        //MARK: - ViewConfig
        private static func viewConfig() -> CxjToastViewConfiguration {
            CxjToastViewConfiguration(
                contentLayout: .fill(insets: .init(top: 20, left: 16, bottom: 20, right: 16)),
                background: .gradient(
                    params: .init(
                        colors: [.black.withAlphaComponent(0.95), .black.withAlphaComponent(0.5)],
                        locations: [0, 1],
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
                                    string: "Some test text",
                                    attributes: .init(
										textColor: .white.withAlphaComponent(0.95),
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
