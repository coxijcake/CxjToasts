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
                background: .blurred(effect: .init(style: .dark)),
                customSourceView: customSourceView
            )
        )
    }
}
