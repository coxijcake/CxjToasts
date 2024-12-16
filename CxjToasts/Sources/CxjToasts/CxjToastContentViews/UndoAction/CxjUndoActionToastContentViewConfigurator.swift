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
		let infoContentView: UIView = infoContentViewForConfig(config)
		let unduControl: UIControl = undoControlForConfigControl(config.unduControl)
		
		return CxjUndoActionToastContentView(
			timingFeedbackView: timingFeedbackView,
			infoContentView: infoContentView,
			undoButton: unduControl
		)
	}
	
	private static func infoContentViewForConfig(_ config: Config) -> UIView {
		let labelsAttributes = CxjLabelConfiguration.LabelAttributes(numberOfLines: 1, textAligment: .left)
		let titleLabelConfig = CxjLabelConfiguration(text: config.title, label: labelsAttributes)
		
		if let subtitle = config.subtitle {
			let subtitleLabelConfig = CxjLabelConfiguration(text: subtitle, label: labelsAttributes)
			return CxjToastTextContentViewConfigurator.viewWithConfig(
				.withSubtitle(
					titleLabelConfig: titleLabelConfig,
					subtitleLabelConfig: subtitleLabelConfig,
					subtitleParams: .init(labelsPadding: 4)
				)
			)
		} else {
			return CxjToastTextContentViewConfigurator.viewWithConfig(.title(labelConfig: titleLabelConfig))
		}
	}
	
	private static func timingFeedbackViewForConfig(_ config: Config.TimingFeedback) -> CxjToastTimingFeedbackView? {
		switch config {
		case .none:
			return nil
		case .number(params: let params):
			return numberTimingFeedbackViewWithParams(params)
		case .progress(params: let params):
			return progressFeedbackViewWithParams(params)
		case .numberWithProgress(numberParams: let numberParams, progressParams: let progressParams):
			let numberView: CxjToastTimingFeedbackView = numberTimingFeedbackViewWithParams(numberParams)
			let progressView: CxjToastTimingFeedbackView = progressFeedbackViewWithParams(progressParams)
			let numberWithProgressFeedbackView: CxjToastTimingFeedbackView = UndoActionToastNumberedWithProgressFeedbackView(
				timingFeebackView: numberView,
				progressFeedbackView: progressView
			)
			
			return numberWithProgressFeedbackView
		case .custom(view: let customView):
			return customView
		}
	}
	
	private static func undoControlForConfigControl(_ control: Config.UndoControl) -> UIControl {
		let configuredControl: UIControl
		
		switch control {
		case .custom(control: let customControl, let actionCompletion):
			configuredControl = customControl
			if let actionCompletion {
				customControl.addAction(
					.init(
						handler: { _ in
							actionCompletion()
						}
					),
					for: .touchUpInside
				)
			}
		case .default(config: let config, actionCompletion: let actionCompletion):
			let button: ToastActionButton = ToastActionButton()

			switch config {
			case .plain(config: let config):
				button.setupConfig(
					.init(
						title: .plain(
							text: config.text,
							color: config.textColor,
							font: config.font
						)
					),
					forState: .normal
				)
			case .attributed(string: let string):
				button.setupConfig(
					.init(title: .attributed(text: string)),
					forState: .normal
				)
			}
			
			if let actionCompletion {
				button.addAction(.init(handler: { _ in
					actionCompletion()
				}), for: .touchUpInside)
			}
			
			configuredControl = button
		}
		
		return configuredControl
	}
	
	private static func numberTimingFeedbackViewWithParams(_ params: Config.TimingFeedback.NumberParams) -> UndoActionToastNumberedTimingFeedbackView {
		return UndoActionToastNumberedTimingFeedbackView(
			config: .init(
				numberColor: params.numberColor,
				numberFont: params.font
			)
		)
	}
	
	private static func progressFeedbackViewWithParams(_ params: Config.TimingFeedback.ProgressParams) -> UndoToastCountdownProgressFeedbackView {
		return UndoToastCountdownProgressFeedbackView(
			progressState: UndoToastCountdownProgressFeedbackView.ProgressState(
				lineWidth: params.lineWidth,
				lineColor: params.lineColor
			)
		)
	}
}
