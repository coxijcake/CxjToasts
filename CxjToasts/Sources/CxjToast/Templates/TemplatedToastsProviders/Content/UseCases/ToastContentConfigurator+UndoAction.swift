//
//  ToastContentConfigurator+UndoAction.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

extension CxjTemplatedToastContentConfiguratorFactory {
	final class UndoActionToastContentConfigurator: CxjTemplatedToastContentConfigurator {
		typealias Data = CxjToastTemplate.UndoActionToastData
		
		let data: Data
		let toastId: UUID
		
		init(data: Data, toastId: UUID) {
			self.data = data
			self.toastId = toastId
		}
		
		func content() -> Content {
			CxjToastContentViewFactory.createContentViewWith(
				config: .undoAction(
					config: .init(
						title: data.title,
						subtitle: data.subtitle,
						unduControl: unduButtonConfigForData(data.undoControl, toastId: toastId),
						timingFeedback: data.timingFeedback
					)
				)
			)
		}
		
		private func unduButtonConfigForData(
			_ data: Data.UndoControl,
			toastId: UUID
		) -> CxjUndoActionToastContentConfiguration.UndoControl {
			switch data.type {
			case .custom(control: let customControl):
				return .custom(
					control: customControl,
					actionCompletion: actionCompletionForData(data, toastId: toastId)
				)
			case .default(config: let config):
				return .default(
					config: config,
					actionCompletion: actionCompletionForData(data, toastId: toastId)
				)
			}
		}
		
		private func actionCompletionForData(_ data: Data.UndoControl, toastId: UUID) -> CxjVoidCompletion? {
			if let actionCompletion = data.actionCompletion {
				return {
					actionCompletion(toastId)
				}
			} else {
				return nil
			}
		}
	}
}
