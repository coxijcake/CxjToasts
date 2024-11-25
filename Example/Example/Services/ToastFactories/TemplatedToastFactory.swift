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
			data: CxjToastTemplate.NativeToastData(
				typeId: "template_toast_test_native",
				title: "Test Toast Toast Toast",
				subtitle: "Some subtitle",
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
			data: CxjToastTemplate.BottomPrimaryToastData(
				typeId: "template_toast_test_bottom_primary",
				customSourceView: customSourceView,
				icon: .init(resource: .closeIcon),
				title: CxjToastTemplate.BottomPrimaryToastData.Title(
					text: "owofmqwofmqowf qowfm qowfmq owfmqow fqowf m",
					numberOfLines: 3,
					textColor: UIColor.black,
					font: .systemFont(ofSize: 21, weight: .bold)
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
			data: CxjToastTemplate.TopStraightToastData(
				typeId: "template_toast_test_top_straight",
				customSourceView: customSourceView,
				icon: .init(resource: .closeIcon),
				title: .init(
					text: "Test straight toast title",
					textColor: .label,
					font: .systemFont(ofSize: 18, weight: .medium)
				),
				background: .colorized(color: .secondarySystemBackground)
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
				typeId: "template_toast_test_undo_action",
				customSourceView: customSourceView,
				title: .init(
					text: "Undo this action",
					textColor: .white.withAlphaComponent(0.85),
					font: .systemFont(ofSize: 14, weight: .regular)
				),
				timingFeedback: .progress,
				undoControl: .init(
					actionCompletion: { toastId in
						print("Undo action pressed for toast with id: \(toastId.uuidString)")
						Task { @MainActor in
							CxjToastsCoordinator.shared.dismissToast(withId: toastId, animated: true)
						}
					},
					type: .default(
						config: .init(
							text: "Undo",
							textColor: .blue,
							font: .systemFont(ofSize: 17, weight: .bold)
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
					displayingBehaviour: .init(handling: .stack(maxVisibleToasts: 3))
				),
				toastView: .init(
					background: .colorized(color: .black.withAlphaComponent(0.95)),
					shadow: .disable,
					corners: .fixed(value: 12, mask: .all)
				)
			)
		)
	}
}
