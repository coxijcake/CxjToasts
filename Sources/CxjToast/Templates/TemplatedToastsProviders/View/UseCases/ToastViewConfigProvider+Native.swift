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
				background: data.background,
				shadow: data.shadow,
				corners: .capsule(mask: .all),
                isUserInteractionEnabled: true
			)
		}
	}
}
