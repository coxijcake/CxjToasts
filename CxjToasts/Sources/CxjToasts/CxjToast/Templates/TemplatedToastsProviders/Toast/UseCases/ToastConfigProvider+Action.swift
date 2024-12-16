//
//  File.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 16/12/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class ActionConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.ActionToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			let sourceView: UIView = data.customSourceView ?? defaultSourceView()
			
			return Config(
				typeId: data.typeId,
				sourceView: sourceView,
				sourceBackground: nil,
				layout: layoutForData(data.toast),
				dismissMethods: data.toast.dismissMethods,
				keyboardHandling: .moveToastUpperKeyboard(additionalOffset: 10),
				animations: data.toast.animations,
				spamProtection: data.toast.spamProtection,
				displayingSameAttributeToastBehaviour: data.toast.displayingBehaviour
			)
		}
		
		private func layoutForData(_ data: Data.Toast) -> Config.Layout {
			Config.Layout(
				constraints: data.constraints,
				placement: data.placement
			)
		}
	}
}
