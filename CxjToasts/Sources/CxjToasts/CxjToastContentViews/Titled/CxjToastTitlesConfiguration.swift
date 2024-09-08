//
//  CxjToastTitlesConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public enum CxjToastTitlesConfiguration {
    case plain(config: Plain)
    case attributed(config: Attributed)
    
	public struct Plain {
		let title: PlainLabel
		let subtitle: PlainLabel?
		
		public init(
			title: PlainLabel,
			subtitle: PlainLabel?
		) {
			self.title = title
			self.subtitle = subtitle
		}
	}
	
	public struct Attributed {
		let title: AttributedLabel
		let subtitle: AttributedLabel?
		
		public init(
			title: AttributedLabel,
			subtitle: AttributedLabel?
		) {
			self.title = title
			self.subtitle = subtitle
		}
	}
	
	public struct PlainLabel {
		public let text: String
		public let labelParams: LabelParams
		
		public init(
			text: String,
			labelParams: LabelParams
		) {
			self.text = text
			self.labelParams = labelParams
		}
	}
	
	public struct AttributedLabel {
		public let text: NSAttributedString
		public let labelParams: LabelParams
		
		public init(
			text: NSAttributedString,
			labelParams: LabelParams
		) {
			self.text = text
			self.labelParams = labelParams
		}
	}
	
	public struct LabelParams {
		public let numberOfLines: Int
		public let textAligment: NSTextAlignment
		
		public init(
			numberOfLines: Int,
			textAligment: NSTextAlignment
		) {
			self.numberOfLines = numberOfLines
			self.textAligment = textAligment
		}
	}
}
