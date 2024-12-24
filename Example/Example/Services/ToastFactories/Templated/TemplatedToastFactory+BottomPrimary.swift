//
//  TemplatedToastFactory+BottomPrimary.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit

extension TemplatedToastFactory {
    static func bottomPrimaryToast(
        customSourceView: UIView?
    ) -> ToastTemplate {
        .bottomPrimary(
            data: .init(
                typeId: "template_toast_test_bottom_primary",
                customSourceView: customSourceView,
                sourceBackground: .init(
                    theme: .colorized(color: .black.withAlphaComponent(0.65)),
                    interaction: .enabled(action: .init(touchEvent: .touchDown, handling: .dismissToast))
                ),
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
