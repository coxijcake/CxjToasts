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
                title: .plain(
                    string: "AirPods Pro",
					attributes: .init(textColor: .black, font: .systemFont(ofSize: 15, weight: .bold))
                ),
                subtitle: .plain(
                    string: "Connected",
					attributes: .init(textColor: .fromFigmaRgb(r: 125, g: 114, b: 112), font: .systemFont(ofSize: 14, weight: .regular))
                ),
				icon: .init(icon: .airpodsTest.withRenderingMode(.alwaysTemplate), tintColor: .black, fixedSize: .init(width: 25, height: 25)),
				background: .gradient(
					params: .init(
						colors: [
							.fromFigmaRgb(r: 193, g: 166, b: 177),
							.fromFigmaRgb(r: 224, g: 195, b: 206)
								],
						locations: [0, 1],
						direction: .init(
							startPoint: .init(x: 0.0, y: 0.0),
							endPoint: .init(x: 1.0, y: 1.0)
						)
					)
				),
				shadow: .enable(
					params: .init(
						offset: .init(width: 0, height: 2),
						color: .black.withAlphaComponent(0.5),
						opacity: 1.0,
						radius: 4
					)
				),
				hapticFeeback: nil
            )
        )
    }
}
