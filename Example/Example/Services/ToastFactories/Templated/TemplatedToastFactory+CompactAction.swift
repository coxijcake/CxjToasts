//
//  TemplatedToastFactory+CompactAction.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit
import CxjToasts

extension TemplatedToastFactory {
    static func compactActionToast(customSourceView: UIView?) -> ToastTemplate {
        let toastActionCompletion: CxjVoidSendableCompletion = {
            print("Compact action toast action")
        }
        
        return .compactAction(
            data: .init(
                typeId: "compact_action_toast_test",
                customSourceView: customSourceView,
                actionControl: .init(
                    actionCompletion: { toastId in
                        Task { @MainActor in
                            CxjToastsCoordinator.shared.dismissToast(withId: toastId, animated: true)
                            toastActionCompletion()
                        }
                    },
                    type: .default(
                        config: .plain(
                            config: .init(text: "Handle", textColor: .white, font: .systemFont(ofSize: 15, weight: .semibold))
                        )
                    )),
                content: .init(
                    title: .init(
                        text: .plain(
                            string: "Smth happend. Handle it.",
                            attributes: .init(
                                textColor: .white,
                                font: .systemFont(ofSize: 14, weight: .regular)
                            )
                        ),
                        label: .init(numberOfLines: 1, textAligment: .left)
                    ),
                    icon: nil
                ),
                toast: .init(
                    placement: .bottom(
                        params: .init(
                            offset: 10,
                            includingSafeArea: true
                        )
                    ),
                    dismissMethods: [.swipe(direction: .bottom), .automatic(time: 3.0), .tap(actionCompletion: toastActionCompletion)],
                    animations: .init(
                        present: .init(
                            animation: .defaultSpring,
                            behaviour: .default(includingNativeViews: [])
                        ),
                        dismiss: .init(
                            animation: .defaultSpring,
                            behaviour: .default(includingNativeViews: [])
                        )
                    ),
                    spamProtection: .off,
                    coexistencePolicy: .init(
                        handling: .stack(
                            attributes: .init(
                                direction: .top,
                                maxVisibleToasts: 3,
                                shouldStopTimerForStackedUnvisibleToasts: true
                            )
                        ),
                        comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
                    )
                ),
                toastView: .init(
                    background: .blurred(effect: .init(style: .dark)),
                    shadow: .disable,
                    corners: .fixed(value: 10, mask: .all)
                ),
				hapticFeeback: nil
            )
        )
    }
}
