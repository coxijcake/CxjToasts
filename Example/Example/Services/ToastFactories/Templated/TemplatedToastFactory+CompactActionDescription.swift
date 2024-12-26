//
//  TemplatedToastFactory+CompactActionDescription.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit

extension TemplatedToastFactory {
    static func compactActionDescription(customSourceView: UIView?) -> ToastTemplate {
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
				background: .colorized(color: .black.withAlphaComponent(0.9)),
				shadow: .init(
					offset: .init(width: 0, height: 2),
					color: .black.withAlphaComponent(0.5),
					opacity: 1.0,
					radius: 2
				),
                customSourceView: customSourceView,
				hapticFeeback: .uiImpact(style: .soft)
            )
        )
    }
}
