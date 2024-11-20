//
//  CxjUndoActionToastContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

public struct CxjUndoActionToastContentConfiguration {
	public let title: CxjTitledToastContentConfiguration
	public let unduControl: UndoControl
	public let timingFeedback: TimingFeedback
	
	public init(
		title: CxjTitledToastContentConfiguration,
		unduControl: UndoControl,
		timingFeedback: TimingFeedback
	) {
		self.title = title
		self.unduControl = unduControl
		self.timingFeedback = timingFeedback
	}
}

extension CxjUndoActionToastContentConfiguration {
	typealias Content = CxjTitledToastContentConfiguration
	
	public enum UndoControl {
		public struct Config {
			public let text: String
			public let textColor: UIColor
			public let font: UIFont
			
			public init(
				text: String,
				textColor: UIColor,
				font: UIFont
			) {
				self.text = text
				self.textColor = textColor
				self.font = font
			}
		}
		
		case custom(control: UIControl)
		case `default`(config: Config)
	}
	
	public enum TimingFeedback {
		case none
		case number(withProgress: Bool)
		case custom(view: CxjToastTimingFeedbackView)
	}
}
