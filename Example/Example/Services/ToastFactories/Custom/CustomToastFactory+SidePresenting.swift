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
				hapticFeeback: nil,
                spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
            )
        }
        
        private static func layoutInsideSourceView(_ sourceView: UIView) -> ToastConfig.Layout {
            ToastConfig.Layout(
                constraints: .init(
                    width: .init(
                        min: sourceView.bounds.size.width * 0.75,
                        max: sourceView.bounds.size.width * 0.75
                    ),
                    height: .init(
                        min: 40,
                        max: 70
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
				animation: .toastPresenting,
                behaviour: .custom(
                    changes: [
						.translation(type: .outOfSourceViewHorizontaly(direction: .left)),
                        .scale(value: .init(x: 0.75, y: 1.0)),
                    ]
                )
            )
        }
        
        private static func dismissAnimation(sourceView: UIView) -> ToastConfig.Animation {
            ToastConfig.Animation(
				animation: .toastDismissing,
                behaviour: .custom(
                    changes: [
						.translation(type: .outOfSourceViewHorizontaly(direction: .right)),
                        .scale(value: .init(x: 0.75, y: 1.0)),
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
				comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
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
                        direction: .init(startPoint: .init(x: 0.1, y: 0.45),
                                         endPoint: .init(x: 0.9, y: 0.85))
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

//MARK: - CxjAnimation extensions
fileprivate extension CxjAnimation {
	static let toastPresenting = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 1.0,
			delay: .zero,
			usingSpringWithDamping: 0.95,
			initialSpringVelocity: 13.0,
			options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState],
			animations: animations,
			completion: completion
		)
	}
	
	static let toastDismissing = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 0.175,
			delay: .zero,
			options: [.curveEaseIn, .beginFromCurrentState],
			animations: animations,
			completion: completion
		)
	}
}
