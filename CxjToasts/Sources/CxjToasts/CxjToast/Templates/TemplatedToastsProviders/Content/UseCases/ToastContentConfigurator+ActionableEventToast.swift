//
//  ToastContentConfigurator+ActionableEventToast.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 16/12/2024.
//

import UIKit

extension CxjTemplatedToastContentConfiguratorFactory {
	final class ActionableEventToastToastContentConfigurator: CxjTemplatedToastContentConfigurator {
		typealias Data = CxjToastTemplate.ActionableEventToastData
		
		let data: Data
		let toastId: UUID
		
		init(data: Data, toastId: UUID) {
			self.data = data
			self.toastId = toastId
		}
		
		func content() -> any Content {
			CxjToastContentViewFactory.createContentViewWith(
				config: .action(
					config: .init(
						actionControl: actionControlForData(data.actionControl, toastId: toastId),
						layout: .init(
							actionControlPlacement: .right,
							paddingToInfoContent: 30
						)
					),
					infoContent: infoContentForData(data.content)
				)
			)
		}
		
		private func infoContentForData(_ data: Data.Content) -> CxjToastContentConfiguration.InfoContentType {
			if let icon = data.icon {
				return .textWithIcon(
					iconConfig: .init(
						layout: .init(
							iconPlacement: .left,
							paddingToContent: 10
						),
						iconParams: icon
					),
					textConfig: .title(labelConfig: data.title)
				)
			} else {
				return .text(
					config: .title(labelConfig: data.title)
				)
			}
		}
		
		private func actionControlForData(
			_ data: Data.ActionControl,
			toastId: UUID
		) -> CxjActionToastContentConfiguration.ActionControl {
			switch data.type {
			case .custom(control: let control):
				return .custom(control: control, actionCompletion: actionCompletionForData(data, toastId: toastId))
			case .default(config: let config):
				return .default(config: config, actionCompletion: actionCompletionForData(data, toastId: toastId))
			}
		}
		
		private func actionCompletionForData(
			_ data: Data.ActionControl,
			toastId: UUID
		) -> CxjVoidCompletion? {
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
