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
				icon: .init(resource: .successMessageIcon),
                title: .plain(
                    string: "Your message was sent",
                    attributes: .init(textColor: .label, font: .systemFont(ofSize: 14, weight: .medium))
                ),
                background: .colorized(color: customSourceView?.backgroundColor ?? .white),
                shadow: .enable(
                    params: .init(
                        offset: .init(width: 0, height: 2),
                        color: .black.withAlphaComponent(0.5),
                        opacity: 1.0,
                        radius: 2
                    )
                ),
				hapticFeeback: .notification(type: .success)
            )
        )
    }
}
