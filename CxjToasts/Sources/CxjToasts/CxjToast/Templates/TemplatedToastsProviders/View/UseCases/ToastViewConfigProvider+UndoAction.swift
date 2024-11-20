//
//  ToastViewConfigProvider+UndoAction.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

extension CxjTemplatedToastViewConfigProviderFactory {
	final class CxjUndoActionToastViewConfigProvider: CxjTemplatedToastViewConfigProvider {
		typealias Data = Template.UndoActionToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			Config(
				contentInsets: .init(top: 8, left: 12, bottom: 8, right: 12),
				background: data.toastView.background,
				shadow: data.toastView.shadow,
				corners: data.toastView.corners
			)
		}
	}
}
