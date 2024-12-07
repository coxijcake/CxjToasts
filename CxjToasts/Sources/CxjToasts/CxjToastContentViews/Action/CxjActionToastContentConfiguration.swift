//
//  CxjActionToastContentConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 05/12/2024.
//

import UIKit

public struct CxjActionToastContentConfiguration {
	public let actionControl: ActionControl
	public let layout: LayoutParams
	
	public init(actionControl: ActionControl, layout: LayoutParams) {
		self.actionControl = actionControl
		self.layout = layout
	}
}

extension CxjActionToastContentConfiguration {
	public struct LayoutParams {
		public enum ActionControlPlacement {
			case left, top, right, bottom
		}
		
		public let actionControlPlacement: ActionControlPlacement
		public let paddingToInfoContent: CGFloat
		
		public init(
			actionControlPlacement: ActionControlPlacement,
			paddingToInfoContent: CGFloat
		) {
			self.actionControlPlacement = actionControlPlacement
			self.paddingToInfoContent = paddingToInfoContent
		}
	}
	
	public enum ActionControl {
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
}
