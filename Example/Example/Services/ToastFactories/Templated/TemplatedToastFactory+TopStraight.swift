//
//  TemplatedToastFactory+TopStraight.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit

extension TemplatedToastFactory {
    static func topStraightToast(
        customSourceView: UIView?
    ) -> ToastTemplate {
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
