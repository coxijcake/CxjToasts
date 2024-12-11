//
//  CxjTextConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 07/12/2024.
//

import UIKit

public enum CxjTextConfiguration {
	case plain(string: String, attributes: PlainTextAttributes)
	case attributed(string: NSAttributedString)
}

extension CxjTextConfiguration {
	public struct PlainTextAttributes {
		public let textColor: UIColor
		public let font: UIFont
		
		public init(
			textColor: UIColor,
			font: UIFont
		) {
			self.textColor = textColor
			self.font = font
		}
	}
}
