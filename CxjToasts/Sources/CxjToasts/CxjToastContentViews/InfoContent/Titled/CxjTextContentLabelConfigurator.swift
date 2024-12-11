//
//  CxjTextContentLabelConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 10/12/2024.
//

import UIKit

@MainActor
enum CxjTextContentLabelConfigurator {
	typealias LabelConfig = CxjLabelConfiguration
	
	static func labelForConfig(_ labelConfig: LabelConfig) -> UILabel {
		let label: UILabel = UILabel()
		label.numberOfLines = labelConfig.label.numberOfLines
		label.textAlignment = labelConfig.label.textAligment
		
		switch labelConfig.text {
		case .plain(string: let string, attributes: let attributes):
			label.text = string
			label.font = attributes.font
			label.textColor = attributes.textColor
		case .attributed(string: let string):
			label.attributedText = string
		}
		
		return label
	}
}
