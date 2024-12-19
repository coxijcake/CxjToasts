//
//  ToastViewConfigProvider+Native.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class NativeToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.NativeToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
                contentLayout: .fill(insets: .init(top: 10, left: 24, bottom: 10, right: 24)),
				background: .colorized(color: data.backgroundColor),
				shadow: .enable(
					params: .init(
						offset: .init(width: 0, height: 4),
						color: .black.withAlphaComponent(0.5),
						opacity: 1.0,
						radius: 10
					)
				),
				corners: .capsule(mask: .all)
			)
		}
	}
}
