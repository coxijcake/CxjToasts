//
//  CxjTitledToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjTitledToastContentConfiguration {
	public let layout: LayoutParams
	public let titles: TitlesParams
	
	public init(
		layout: LayoutParams,
		titles: TitlesParams
	) {
		self.layout = layout
		self.titles = titles
	}
}

extension CxjTitledToastContentConfiguration {
	public struct LayoutParams {
		public let labelsPadding: CGFloat
		
		public init(
			labelsPadding: CGFloat = 4
		) {
			self.labelsPadding = labelsPadding
		}
	}
	
	public enum TitlesParams {
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
			public let textColor: UIColor
			public let font: UIFont
			public let numberOfLines: Int
			public let textAligment: NSTextAlignment
			
			public init(
				textColor: UIColor,
				font: UIFont,
				numberOfLines: Int,
				textAligment: NSTextAlignment
			) {
				self.textColor = textColor
				self.font = font
				self.numberOfLines = numberOfLines
				self.textAligment = textAligment
			}
		}
	}
}
