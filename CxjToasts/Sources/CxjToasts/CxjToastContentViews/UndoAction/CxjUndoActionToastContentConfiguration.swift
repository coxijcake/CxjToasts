//
//  CxjUndoActionToastContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

/// Configuration for an undo action toast, typically used to display an undoable operation with timing feedback.
public struct CxjUndoActionToastContentConfiguration {
	/// Title label configuration.
	public let title: Label
	
	/// Subtitle label configuration (optional).
	public let subtitle: Label?
	
	/// Configuration for the undo control (e.g., a button).
	public let unduControl: UndoControl
	
	/// Configuration for the timing feedback view.
	public let timingFeedback: TimingFeedback
	
	/// Initializes the configuration for an undo action toast.
	/// - Parameters:
	///   - title: Configuration for the title label.
	///   - subtitle: Configuration for the subtitle label (optional).
	///   - unduControl: Configuration for the undo control.
	///   - timingFeedback: Configuration for the timing feedback view.
	public init(
		title: Label,
		subtitle: Label?,
		unduControl: UndoControl,
		timingFeedback: TimingFeedback
	) {
		self.title = title
		self.subtitle = subtitle
		self.unduControl = unduControl
		self.timingFeedback = timingFeedback
	}
}

// MARK: - Nested Types
extension CxjUndoActionToastContentConfiguration {
	/// Represents a label configuration, such as title or subtitle.
	public typealias Label = CxjLabelConfiguration
	
	// MARK: - Undo Control
	/// Represents the undo control displayed in the toast.
	public enum UndoControl {
		/// Configuration for the title of the undo control.
		public enum TitleConfig {
			/// Plain text configuration for the undo control's title.
			public struct PlainTitleConfig {
				/// The text displayed in the undo control.
				public let text: String
				
				/// The color of the text in the undo control.
				public let textColor: UIColor
				
				/// The font used for the text in the undo control.
				public let font: UIFont
				
				/// Initializes the configuration for a plain-text title.
				/// - Parameters:
				///   - text: The text displayed in the undo control.
				///   - textColor: The color of the text.
				///   - font: The font used for the text.
				public init(text: String, textColor: UIColor, font: UIFont) {
					self.text = text
					self.textColor = textColor
					self.font = font
				}
			}
			
			/// A plain text title configuration.
			case plain(config: PlainTitleConfig)
			
			/// An attributed string configuration for the title.
			case attributed(string: NSAttributedString)
		}
		
		/// A custom undo control (e.g., a custom `UIControl`).
		/// - Parameters:
		///   - control: The custom control to display.
		///   - actionCompletion: Optional completion handler to execute when the undo action is triggered.
		case custom(control: UIControl, actionCompletion: CxjVoidCompletion?)
		
		/// A default undo control, such as a button, with title configuration.
		/// - Parameters:
		///   - config: Title configuration for the control.
		///   - actionCompletion: Optional completion handler to execute when the undo action is triggered.
		case `default`(config: TitleConfig, actionCompletion: CxjVoidCompletion?)
	}
	
	// MARK: - Timing Feedback
	/// Represents the timing feedback configuration for the toast.
	public enum TimingFeedback {
		/// Parameters for displaying a numerical countdown.
		public struct NumberParams {
			/// The color of the number displayed in the timing feedback.
			public let numberColor: UIColor
			
			/// The font used for the number in the timing feedback.
			public let font: UIFont
			
			/// Initializes the parameters for numerical timing feedback.
			/// - Parameters:
			///   - numberColor: The color of the countdown number.
			///   - font: The font used for the countdown number.
			public init(
				numberColor: UIColor,
				font: UIFont = .monospacedDigitSystemFont(ofSize: 15, weight: .bold)
			) {
				self.numberColor = numberColor
				self.font = font
			}
		}
		
		/// Parameters for displaying progress feedback (e.g., a progress bar or circle).
		public struct ProgressParams {
			/// The line width for the progress feedback.
			public let lineWidth: CGFloat
			
			/// The line color for the progress feedback.
			public let lineColor: UIColor
			
			/// Initializes the parameters for progress feedback.
			/// - Parameters:
			///   - lineWidth: The width of the progress line.
			///   - lineColor: The color of the progress line.
			public init(
				lineWidth: CGFloat,
				lineColor: UIColor
			) {
				self.lineWidth = lineWidth
				self.lineColor = lineColor
			}
		}
		
		/// No timing feedback.
		case none
		
		/// Displays numerical timing feedback.
		case number(params: NumberParams)
		
		/// Displays progress-based timing feedback.
		case progress(params: ProgressParams)
		
		/// Displays both numerical and progress-based timing feedback.
		case numberWithProgress(numberParams: NumberParams, progressParams: ProgressParams)
		
		/// A custom timing feedback view.
		/// - Parameter view: A custom `CxjToastTimingFeedbackView`.
		case custom(view: CxjToastTimingFeedbackView)
	}
}
