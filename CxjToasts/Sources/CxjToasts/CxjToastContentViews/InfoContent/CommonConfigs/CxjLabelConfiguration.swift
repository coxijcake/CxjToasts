//
//  CxjLabelConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/12/2024.
//

import UIKit

public struct CxjLabelConfiguration {
	let text: CxjTextConfiguration
	let label: LabelAttributes
	
	public init(text: CxjTextConfiguration, label: LabelAttributes) {
		self.text = text
		self.label = label
	}
}

extension CxjLabelConfiguration {
	public struct LabelAttributes {
		let numberOfLines: Int
		let textAligment: NSTextAlignment
		
		public init(numberOfLines: Int, textAligment: NSTextAlignment) {
			self.numberOfLines = numberOfLines
			self.textAligment = textAligment
		}
	}
}
