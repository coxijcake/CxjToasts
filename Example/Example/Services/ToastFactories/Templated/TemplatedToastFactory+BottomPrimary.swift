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
					theme: .colorized(color: .black.withAlphaComponent(0.8)),
					interaction: .enabled(
						action: .init(
							touchEvent: .touchDown,
							handling: .dismissToast
						)
					)
				),
				icon: .init(
					icon: .init(resource: .wiFiNoConnectionIcon),
					fixedSize: .init(width: 40, height: 40)
				),
                title: .init(
                    text: .plain(
						string: "Go back online to use this feature",
						attributes: .init(
							textColor: .black,
							font: .systemFont(ofSize: 21, weight: .bold)
						)
                    ),
                    label: .init(
                        numberOfLines: 3,
                        textAligment: .center
                    )
                ),
				subtitle: .init(
					text: .plain(
						string: "Check your network status",
						attributes: .init(
							textColor: .black.withAlphaComponent(0.85),
							font: .systemFont(ofSize: 16, weight: .thin)
						)
					),
					label: .init(
						numberOfLines: 1,
						textAligment: .center
					)
				),
				background: .colorized(color: .white),
				shadow: .init(
					offset: .init(width: 0, height: 4),
					color: .black.withAlphaComponent(0.5),
					opacity: 1.0,
					radius: 10
				),
				dismissMethods: [
					.automatic(time: 3.0),
					.swipe(direction: .bottom)
				],
				hapticFeeback: .uiImpact(style: .heavy)
            )
        )
    }
}
