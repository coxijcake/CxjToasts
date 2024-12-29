//
//  CxjLabelConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/12/2024.
//

import UIKit

/// Configuration for customizing label appearance and behavior.
///
/// Use this structure to define the text properties and layout attributes of a label
/// displayed within a toast.
public struct CxjLabelConfiguration {
	
	/// The text configuration, including its content, font, and color.
	public let text: CxjTextConfiguration
	
	/// Attributes for customizing the label layout and behavior.
	public let label: LabelAttributes
	
	/// Initializes the label configuration.
	///
	/// - Parameters:
	///   - text: The text configuration for the label.
	///   - label: The layout and behavioral attributes for the label.
	public init(text: CxjTextConfiguration, label: LabelAttributes) {
		self.text = text
		self.label = label
	}
}

extension CxjLabelConfiguration {
	
	/// Attributes for customizing label layout and behavior.
	public struct LabelAttributes {
		
		/// The maximum number of lines for the label's text.
		public let numberOfLines: Int
		
		/// The text alignment for the label.
		public let textAligment: NSTextAlignment
		
		/// The minimum font scale factor for the label, enabling dynamic text resizing.
		///
		/// - Note: If `nil`, the label will not scale its font size dynamically.
		public let minimumFontScaleFactor: CGFloat?
		
		/// Initializes the label attributes.
		///
		/// - Parameters:
		///   - numberOfLines: The maximum number of lines for the label's text.
		///   - textAligment: The text alignment for the label.
		///   - minimumFontScaleFactor: The minimum font scale factor for dynamic resizing. Defaults to `nil`.
		public init(
			numberOfLines: Int,
			textAligment: NSTextAlignment,
			minimumFontScaleFactor: CGFloat? = nil
		) {
			self.numberOfLines = numberOfLines
			self.textAligment = textAligment
			self.minimumFontScaleFactor = minimumFontScaleFactor
		}
	}
}
