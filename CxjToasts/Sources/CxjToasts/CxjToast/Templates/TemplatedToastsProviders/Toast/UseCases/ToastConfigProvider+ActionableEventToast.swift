//
//  ToastConfigProvider+ActionableEventToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 16/12/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class ActionableEventToastConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.ActionableEventToastData
		
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
				layout: layoutForData(data.toast, insideView: sourceView),
				dismissMethods: data.toast.dismissMethods,
				keyboardHandling: .moveToastUpperKeyboard(additionalOffset: 10),
				animations: data.toast.animations,
				hapticFeeback: data.hapticFeeback,
				spamProtection: data.toast.spamProtection,
                coexistencePolicy: data.toast.coexistencePolicy
			)
		}
		
		private func layoutForData(_ data: Data.Toast, insideView sourceView: UIView) -> Config.Layout {
			return Config.Layout(
				constraints: constraintsForData(data, insideView: sourceView),
				placement: data.placement
			)
		}
		
		private func constraintsForData(_ data: Data.Toast, insideView sourceView: UIView) -> Config.Constraints {
			let fixedWidth: CGFloat = sourceView.frame.size.width - 10
			let minHeight: CGFloat = 54
			let maxHeight: CGFloat = 65
			
			return .init(
				width: .init(min: fixedWidth, max: fixedWidth),
				height: .init(min: minHeight, max: maxHeight)
			)
		}
	}
}
