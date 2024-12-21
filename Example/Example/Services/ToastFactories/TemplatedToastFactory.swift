//
//  TemplatedToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

@MainActor
enum TemplatedToastFactory {
	static func toastTemplateForType(
		_ templateType: TemplatedToastType,
		customSourceView: UIView? = nil
	) -> CxjToastTemplate {
		switch templateType {
		case .native:
			return nativeToast()
		case .bottomPrimary:
			return bottomPrimaryToast(
				customSourceView: customSourceView
			)
		case .topStraight:
			return topStraightToast(
				customSourceView: customSourceView
			)
        case .minimalizedGlobalStatus:
            return minimalizedGlobalStatus()
        case .compactActionDescription:
            return compactActionDescription(
                customSourceView: customSourceView
            )
		case .compactAction:
			return compactActionToast(
				customSourceView: customSourceView
			)
		case .undoAction:
			return undoActionToast(
				customSourceView: customSourceView
			)
		}
	}
}

//MARK: - Native
private extension TemplatedToastFactory {
	static func nativeToast() -> CxjToastTemplate {
		.native(
			data: .init(
				typeId: "template_toast_test_native",
//				typeId: UUID().uuidString,
				title: .plain(
					string: "Test toast toast",
					attributes: .init(textColor: .black, font: .systemFont(ofSize: 15, weight: .bold))
				),
				subtitle: .plain(
					string: "Some subtitle",
					attributes: .init(textColor: .black.withAlphaComponent(0.85), font: .systemFont(ofSize: 14, weight: .regular))
				),
				icon: .init(resource: .closeIcon),
				backgroundColor: .white
			)
		)
	}
}

//MARK: - Bottom Primary
private extension TemplatedToastFactory {
	static func bottomPrimaryToast(
		customSourceView: UIView?
	) -> CxjToastTemplate {
		.bottomPrimary(
			data: .init(
				typeId: "template_toast_test_bottom_primary",
				customSourceView: customSourceView,
				sourceBackground: .init(
					theme: .colorized(color: .black.withAlphaComponent(0.65)),
					interaction: .enabled(action: .init(touchEvent: .touchDown, handling: .dismissToast))
				),
//				sourceBackground: nil,
				icon: .init(icon: .init(resource: .closeIcon), fixedSize: .init(width: 40, height: 40)),
				title: .init(
					text: .plain(
						string: "owofmqwofmqowf qowfm qowfmq owfmqow fqowf m",
						attributes: .init(textColor: .black, font: .systemFont(ofSize: 21, weight: .bold))
					),
					label: .init(
						numberOfLines: 3,
						textAligment: .center
					)
				),
				subtitle: nil,
				background: .colorized(color: .white),
				shadowColor: .black.withAlphaComponent(0.5)
			)
		)
	}
}

//MARK: - Top Straight
private extension TemplatedToastFactory {
	static func topStraightToast(
		customSourceView: UIView?
	) -> CxjToastTemplate {
		.topStraight(
			data: .init(
				typeId: "template_toast_test_top_straight",
				customSourceView: customSourceView,
				icon: .init(resource: .closeIcon),
				title: .plain(
					string: "Test straight toast title",
					attributes: .init(textColor: .label, font: .systemFont(ofSize: 18, weight: .medium))
				),
				background: .colorized(color: customSourceView?.backgroundColor?.withAlphaComponent(0.95) ?? .white),
                shadow: .enable(
                    params: .init(
                        offset: .init(width: 0, height: 3),
                        color: .black.withAlphaComponent(0.75),
                        opacity: 1.0,
                        radius: 4
                    )
                )
			)
		)
	}
}


//MARK: - MinimalizedGlobalStatus
private extension TemplatedToastFactory {
    static func minimalizedGlobalStatus() -> CxjToastTemplate {
        return .minimalizedGlobalStatus(
            data: .init(
                typeId: "minimalized_global_status_test",
                icon: .init(
                    icon: .closeIcon,
                    fixedSize: .init(width: 20, height: 20)
                ),
                title: .plain(
                    string: "No connection",
                    attributes: .init(
                        textColor: .white,
                        font: .systemFont(ofSize: 13, weight: .semibold)
                    )
                ),
                background: .colorized(color: .init(red: 0.349, green: 0.8, blue: 0.298, alpha: 1.0)),
                dismissMethods: [
                    .automatic(time: 2.5),
                    .swipe(direction: .top),
                    .tap(actionCompletion: nil)
                ]
            )
        )
    }
}

//MARK: - CompactActionDescription
private extension TemplatedToastFactory {
    static func compactActionDescription(customSourceView: UIView?) -> CxjToastTemplate {
        return .compactActionDescription(
            data: .init(
                typeId: "compact_action_description_test",
                title: .plain(
                    string: "Sent",
                    attributes: .init(
                        textColor: .white,
                        font: .systemFont(ofSize: 12, weight: .semibold)
                    )
                ),
                background: .blurred(effect: .init(style: .dark)),
                customSourceView: customSourceView
            )
        )
    }
}

//MARK: - Action
private extension TemplatedToastFactory {
	static func compactActionToast(customSourceView: UIView?) -> CxjToastTemplate {
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
								maxVisibleToasts: 3,
								shouldStopTimerForStackedUnvisibleToasts: true
							)
						),
						comparisonCriteria: .init(rule: .and)
					)
				),
				toastView: .init(
					background: .blurred(effect: .init(style: .dark)),
					shadow: .disable,
					corners: .fixed(value: 10, mask: .all)
				)
			)
		)
	}
}

//MARK: - Undo action
private extension TemplatedToastFactory {
	static func undoActionToast(
		customSourceView: UIView?
	) -> CxjToastTemplate {
		.undoAction(
			data: .init(
//				typeId: "template_toast_test_undo_action",
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
						handling: .stack(attributes: .init(maxVisibleToasts: 3, shouldStopTimerForStackedUnvisibleToasts: true)),
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
