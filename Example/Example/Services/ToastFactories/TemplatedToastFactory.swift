//
//  TemplatedToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

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
