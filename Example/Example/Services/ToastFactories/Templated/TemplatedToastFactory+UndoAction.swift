//
//  TemplatedToastFactory+UndoAction.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit
import CxjToasts

extension TemplatedToastFactory {
    static func undoActionToast(
        customSourceView: UIView?
    ) -> ToastTemplate {
        .undoAction(
            data: .init(
//                typeId: "template_toast_test_undo_action",
                typeId: UUID().uuidString,
                customSourceView: customSourceView,
                title: .plain(string: "Undo this action", attributes: .init(textColor: .white.withAlphaComponent(0.85), font: .systemFont(ofSize: 14, weight: .semibold))),
                subtitle: nil,
                timingFeedback: .numberWithProgress(
                    numberParams: .init(numberColor: .white, font: .monospacedDigitSystemFont(ofSize: 14, weight: .bold)),
                    progressParams: .init(lineWidth: 2, lineColor: .white)
                ),
                undoControl: .init(
                    actionCompletion: { toastId in
                        Task { @MainActor in
                            CxjToastsCoordinator.shared.dismissToast(withId: toastId, animated: true)
                        }
                    },
                    type: .default(
                        config: .plain(
                            config: .init(text: "Undo", textColor: .blue.withAlphaComponent(0.9), font: .systemFont(ofSize: 17, weight: .bold))
                        )
                    )
                ),
                toast: .init(
                    placement: .bottom(params: .init(offset: 20, includingSafeArea: true)),
                    dismissMethods: [.swipe(direction: .bottom), .automatic(time: 5.0)],
                    animations: .init(
                        present: .init(animation: .defaultSpring, behaviour: .default(includingNativeViews: [])),
                        dismiss: .init(animation: .defaultSpring, behaviour: .default(includingNativeViews: []))
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
                        comparisonCriteria: .init(attibutes: [.sourceView, .placement(includingYOffset: true)], rule: .and)
                    )
                ),
                toastView: .init(
                    background: .colorized(color: .black.withAlphaComponent(0.9)),
                    shadow: .disable,
                    corners: .fixed(value: 12, mask: .all)
                )
            )
        )
    }
}
