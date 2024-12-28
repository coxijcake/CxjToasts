//
//  TemplatedToastFactory+ActionableEventToast.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit
import CxjToasts

extension TemplatedToastFactory {
    static func actionableEventToast(customSourceView: UIView?) -> ToastTemplate {
        let toastActionCompletion: CxjVoidSendableCompletion = {
            print("View saved image button pressed")
        }
        
        return .actionableEventToast(
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
                            config: .init(text: "View", textColor: .white, font: .systemFont(ofSize: 15, weight: .semibold))
                        )
                    )),
                content: .init(
                    title: .init(
                        text: .plain(
                            string: "Your image successfully saved",
                            attributes: .init(
                                textColor: .white,
                                font: .systemFont(ofSize: 14, weight: .regular)
                            )
                        ),
                        label: .init(numberOfLines: 1, textAligment: .left)
                    ),
					icon: .init(
						icon: .warsawCenter,
						contentMode: .scaleAspectFill,
						fixedSize: .init(width: 36, height: 36),
						cornerRadius: 18
					)
                ),
                toast: .init(
                    placement: .bottom(
                        params: .init(
                            offset: 10,
                            includingSafeArea: true
                        )
                    ),
                    dismissMethods: [
						.swipe(direction: .bottom),
						.automatic(time: 2.5),
						.tap(actionCompletion: toastActionCompletion)
					],
                    animations: .init(
                        present: .init(
                            animation: .defaultSpring,
							behaviour: .default(adjustForTopFeatures: [])
                        ),
                        dismiss: .init(
                            animation: .defaultSpring,
							behaviour: .default(adjustForTopFeatures: [])
                        )
                    ),
                    spamProtection: .off,
                    coexistencePolicy: .init(
						handling: .hide(attributes: .init(shouldStopTimerForHiddenToasts: true)
                        ),
                        comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
                    )
                ),
                toastView: .init(
					background: .colorized(color: .black.withAlphaComponent(0.75)),
                    shadow: .disable,
                    corners: .fixed(value: 10, mask: .all)
                ),
				hapticFeeback: nil
            )
        )
    }
}
