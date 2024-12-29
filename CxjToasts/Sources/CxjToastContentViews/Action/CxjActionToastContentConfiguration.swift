//
//  CxjActionToastContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 05/12/2024.
//

import UIKit

/// Configuration for an action-based toast content.
public struct CxjActionToastContentConfiguration {
	/// The action control (e.g., a button) associated with the toast.
	public let actionControl: ActionControl
	
	/// Layout parameters for the action control and its relation to the informational content.
	public let layout: LayoutParams
	
	/// Initializes the configuration for an action-based toast.
	/// - Parameters:
	///   - actionControl: The action control (e.g., a button) to display in the toast.
	///   - layout: Layout parameters for the action control and its relation to the informational content.
	public init(actionControl: ActionControl, layout: LayoutParams) {
		self.actionControl = actionControl
		self.layout = layout
	}
}

// MARK: - Layout Parameters
extension CxjActionToastContentConfiguration {
	/// Layout parameters for positioning the action control in relation to the informational content.
	public struct LayoutParams {
		/// Placement options for the action control.
		public enum ActionControlPlacement {
			/// Place the action control to the left of the informational content.
			case left
			
			/// Place the action control above the informational content.
			case top
			
			/// Place the action control to the right of the informational content.
			case right
			
			/// Place the action control below the informational content.
			case bottom
		}
		
		/// The placement of the action control relative to the informational content.
		public let actionControlPlacement: ActionControlPlacement
		
		/// The padding between the action control and the informational content.
		public let paddingToInfoContent: CGFloat
		
		/// Initializes the layout parameters for the action control.
		/// - Parameters:
		///   - actionControlPlacement: Placement of the action control relative to the informational content.
		///   - paddingToInfoContent: Padding between the action control and the informational content.
		public init(
			actionControlPlacement: ActionControlPlacement,
			paddingToInfoContent: CGFloat
		) {
			self.actionControlPlacement = actionControlPlacement
			self.paddingToInfoContent = paddingToInfoContent
		}
	}
}

// MARK: - Action Control
extension CxjActionToastContentConfiguration {
	/// Represents the action control displayed in the toast.
	public enum ActionControl {
		/// Configuration for the title of the action control.
		public enum TitleConfig {
			/// Plain text configuration for the action control's title.
			public struct PlainTitleConfig {
				/// The text displayed in the action control.
				public let text: String
				
				/// The color of the text in the action control.
				public let textColor: UIColor
				
				/// The font used for the text in the action control.
				public let font: UIFont
				
				/// Initializes the configuration for a plain-text title.
				/// - Parameters:
				///   - text: The text displayed in the action control.
				///   - textColor: The color of the text.
				///   - font: The font used for the text.
				public init(text: String, textColor: UIColor, font: UIFont) {
					self.text = text
					self.textColor = textColor
					self.font = font
				}
			}
			
			/// A plain text title configuration.
			/// - Parameter config: Configuration for plain text.
			case plain(config: PlainTitleConfig)
			
			/// An attributed string configuration for the title.
			/// - Parameter string: An attributed string used for the title.
			case attributed(string: NSAttributedString)
		}
		
		/// A custom action control (e.g., a custom `UIControl`).
		/// - Parameters:
		///   - control: The custom control to display.
		///   - actionCompletion: Optional completion handler to execute when the action is triggered.
		case custom(control: UIControl, actionCompletion: CxjVoidCompletion?)
		
		/// A default action control, such as a button, with title configuration.
		/// - Parameters:
		///   - config: Title configuration for the control.
		///   - actionCompletion: Optional completion handler to execute when the action is triggered.
		case `default`(config: TitleConfig, actionCompletion: CxjVoidCompletion?)
	}
}
