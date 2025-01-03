//
//  ToastViewConfigProvider+ActionableEventToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 16/12/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class ActionableEventToastToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.ActionableEventToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
                contentLayout: .fill(insets: .init(top: 8, left: 10, bottom: 8, right: 16)),
				background: data.toastView.background,
				shadow: data.toastView.shadow,
				corners: data.toastView.corners,
                isUserInteractionEnabled: true
			)
		}
	}
}
