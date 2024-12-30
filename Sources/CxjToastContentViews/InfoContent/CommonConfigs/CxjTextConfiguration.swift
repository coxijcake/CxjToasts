//
//  CxjTextConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 07/12/2024.
//

import UIKit

/// Represents the text configuration used in toast components.
///
/// This enumeration provides options for configuring plain or attributed text
/// for displaying in a toast.
public enum CxjTextConfiguration {
	
	/// A plain text configuration with attributes.
	///
	/// - Parameters:
	///   - string: The plain text content.
	///   - attributes: The attributes to customize the text's appearance.
	case plain(string: String, attributes: PlainTextAttributes)
	
	/// An attributed text configuration.
	///
	/// - Parameter string: The attributed string content, including any applied styles or formatting.
	case attributed(string: NSAttributedString)
}

extension CxjTextConfiguration {
	
	/// Attributes for customizing the appearance of plain text.
	public struct PlainTextAttributes {
		
		/// The color of the text.
		public let textColor: UIColor
		
		/// The font of the text.
		public let font: UIFont
		
		/// Initializes the plain text attributes.
		///
		/// - Parameters:
		///   - textColor: The color of the text.
		///   - font: The font used for the text.
		public init(
			textColor: UIColor,
			font: UIFont
		) {
			self.textColor = textColor
			self.font = font
		}
	}
}
