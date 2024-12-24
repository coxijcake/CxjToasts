//
//  TemplatedToastFactory+Native.swift
//  Example
//
//  Created by Nikita Begletskiy on 24/12/2024.
//

import UIKit

extension TemplatedToastFactory {
    static func nativeToast() -> ToastTemplate {
        .native(
            data: .init(
                typeId: "template_toast_test_native",
//                typeId: UUID().uuidString,
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
