//
//  CxjUndoActionToastContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

public struct CxjUndoActionToastContentConfiguration {
	public let title: Text
	public let subtitle: Text?
	public let unduControl: UndoControl
	public let timingFeedback: TimingFeedback
	
	public init(
		title: Text,
		subtitle: Text?,
		unduControl: UndoControl,
		timingFeedback: TimingFeedback
	) {
		self.title = title
		self.subtitle = subtitle
		self.unduControl = unduControl
		self.timingFeedback = timingFeedback
	}
}

extension CxjUndoActionToastContentConfiguration {
	public typealias Text = CxjTextConfiguration
	
	public enum UndoControl {
		public enum TitleConfig {
			public struct PlainTitleConfig {
				public let text: String
				public let textColor: UIColor
				public let font: UIFont
				
				public init(text: String, textColor: UIColor, font: UIFont) {
					self.text = text
					self.textColor = textColor
					self.font = font
				}
			}
			
			case plain(config: PlainTitleConfig)
			case attributed(string: NSAttributedString)
		}
		
		case custom(control: UIControl)
		case `default`(config: TitleConfig, actionCompletion: CxjVoidCompletion?)
	}
	
	public enum TimingFeedback {
		public struct NumberParams {
			public let numberColor: UIColor
			public let font: UIFont
			
			public init(
				numberColor: UIColor,
				font: UIFont = .monospacedDigitSystemFont(ofSize: 15, weight: .bold)
			) {
				self.numberColor = numberColor
				self.font = font
			}
		}
		
		public struct ProgressParams {
			public let lineWidth: CGFloat
			public let lineColor: UIColor
			
			public init(
				lineWidth: CGFloat,
				lineColor: UIColor
			) {
				self.lineWidth = lineWidth
				self.lineColor = lineColor
			}
		}
		
		case none
		case number(params: NumberParams)
		case progress(params: ProgressParams)
		case numberWithProgress(numberParams: NumberParams, progressParams: ProgressParams)
		case custom(view: CxjToastTimingFeedbackView)
	}
}
