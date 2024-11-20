//
//  UndoActionToastContentConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

final class UndoActionToastContentConfigurator: CxjTemplatedToastContentConfigurator {
	typealias Data = CxjToastTemplate.UndoActionToastData
	
	let data: Data
	
	init(data: Data) {
		self.data = data
	}
	
	func content() -> Content {
		CxjToastContentViewFactory.createContentViewWith(
			config: .undoAction(
				config: .init(
					title: titleConfigForData(data.title),
					unduControl: unduButtonConfigForData(data.undoControl),
					timingFeedback: timingFeedbackConfigForData(data.timingFeedback)
				)
			)
		)
	}
	
	private func titleConfigForData(_ data: Data.Title) -> CxjTitledToastContentConfiguration {
		.init(
			layout: .init(),
			titles: .plain(
				config: .init(
					title: .init(
						text: data.text,
						labelParams: .init(
							textColor: data.textColor,
							font: data.font,
							numberOfLines: 1,
							textAligment: .left
						)
					),
					subtitle: nil
				)
			)
		)
	}
	
	private func unduButtonConfigForData(_ data: Data.UndoControl) -> CxjUndoActionToastContentConfiguration.UndoControl {
		switch data.type {
		case .custom(control: let customControl):
			return .custom(control: customControl)
		case .default(config: let config):
			return .default(
				config: .init(
					text: config.text,
					textColor: config.textColor,
					font: config.font
				)
			)
		}
	}
	
	private func timingFeedbackConfigForData(_ data: Data.TimingFeedback) -> CxjUndoActionToastContentConfiguration.TimingFeedback {
		switch data {
		case .none:
				.none
		case .custom(view: let view):
				.custom(view: view)
		case .number(withProgress: let withProgress):
				.number(withProgress: withProgress)
		}
	}
}
