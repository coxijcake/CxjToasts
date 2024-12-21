//
//  ToastConfigProvider+UndoAction.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class UndoActionConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.UndoActionToastData
		
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
				layout: layoutForData(data, sourceView: sourceView),
				dismissMethods: data.toast.dismissMethods,
				keyboardHandling: .moveToastUpperKeyboard(additionalOffset: 10),
				animations: data.toast.animations,
				spamProtection: data.toast.spamProtection,
                coexistencePolicy: data.toast.coexistencePolicy
			)
		}
		
		private func layoutForData(_ data: Data, sourceView: UIView) -> Config.Layout {
			Config.Layout(
				constraints: constraintsForData(data, sourceView: sourceView),
				placement: data.toast.placement
			)
		}
		
		private func constraintsForData(_ data: Data, sourceView: UIView) -> Config.Constraints {
			let fixedWidth: CGFloat = sourceView.bounds.size.width - 16 * 2
			
			return .init(
				width: .init(min: fixedWidth, max: fixedWidth),
				height: .init(min: 48, max: 62)
			)
		}
	}
}
