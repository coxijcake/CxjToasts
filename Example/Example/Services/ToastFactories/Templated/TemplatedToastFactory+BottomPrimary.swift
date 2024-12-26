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
				sourceBackground: nil,
                icon: .init(icon: .init(resource: .closeIcon), fixedSize: .init(width: 40, height: 40)),
                title: .init(
                    text: .plain(
                        string: "Your data has been synced with the server",
						attributes: .init(textColor: .black, font: .systemFont(ofSize: 21, weight: .bold))
                    ),
                    label: .init(
                        numberOfLines: 3,
                        textAligment: .center
                    )
                ),
                subtitle: nil,
				background: .colorized(color: .white),
				shadow: .init(
					offset: .init(width: 0, height: 4),
					color: .black.withAlphaComponent(0.5),
					opacity: 1.0,
					radius: 10
				),
				hapticFeeback: .uiImpact(style: .heavy)
            )
        )
    }
}
