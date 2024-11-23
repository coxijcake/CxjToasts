//
//  CxjUndoActionToastContentViewConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 12/11/2024.
//

import UIKit

@MainActor
enum CxjUndoActionToastContentViewConfigurator {
	typealias Config = CxjUndoActionToastContentConfiguration
	
	static func configuredContentViewWithConfig(
		_ config: Config
	) -> CxjUndoActionToastContentView {
		let timingFeedbackView: CxjToastTimingFeedbackView? = timingFeedbackViewForConfig(config.timingFeedback)
		let infoContentView: UIView = infoContentViewForConfig(config.title)
		let unduControl: UIControl = undoControlForConfig(config.unduControl)
		
		return CxjUndoActionToastContentView(
			timingFeedbackView: timingFeedbackView,
			infoContentView: infoContentView,
			undoButton: unduControl
		)
	}
	
	private static func infoContentViewForConfig(_ config: Config.Content) -> UIView {
		let view: CxjTitledToastContentView = CxjTitledToastContentView()
		view.configureWith(configuration: config)
		
		return view
	}
	
	private static func timingFeedbackViewForConfig(_ config: Config.TimingFeedback) -> CxjToastTimingFeedbackView? {
		switch config {
		case .none:
			return nil
		case .number(withProgress: _):
			return nil
		case .custom(view: let customView):
			return customView
		}
	}
	
	private static func undoControlForConfig(_ config: Config.UndoControl) -> UIControl {
		switch config {
		case .custom(control: let customControl):
			return customControl
		case .default(config: let config):
			let button: CxjUndoToastActionButton = CxjUndoToastActionButton()
			button.setTitle(config.text, for: .normal)
			button.titleLabel?.font = config.font
			button.setTitleColor(config.textColor, for: .normal)
			button.addAction(.init(handler: { _ in
				config.actionCompletion?()
			}), for: .touchUpInside)
			
			return button
		}
	}
}
