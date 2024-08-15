//
//  CxjToastTitlesConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import Foundation

public enum CxjToastTitlesConfiguration {
	public struct TitledToastConfiguration {
		let title: ToastLabelConfiguration
		let subtitle: ToastLabelConfiguration?
		
		public init(
			title: ToastLabelConfiguration,
			subtitle: ToastLabelConfiguration?
		) {
			self.title = title
			self.subtitle = subtitle
		}
	}
	
	public struct TitledToastAttributedConfiguration {
		let title: ToastAttributedLabelConfiguration
		let subtitle: ToastAttributedLabelConfiguration?
		
		public init(
			title: ToastAttributedLabelConfiguration,
			subtitle: ToastAttributedLabelConfiguration?
		) {
			self.title = title
			self.subtitle = subtitle
		}
	}
	
	public struct ToastLabelConfiguration {
		public let text: String
		public let labelParams: ToastLabelParams
		
		public init(
			text: String,
			labelParams: ToastLabelParams
		) {
			self.text = text
			self.labelParams = labelParams
		}
	}
	
	public struct ToastAttributedLabelConfiguration {
		public let text: NSAttributedString
		public let labelParams: ToastLabelParams
		
		public init(
			text: NSAttributedString,
			labelParams: ToastLabelParams
		) {
			self.text = text
			self.labelParams = labelParams
		}
	}
	
	public struct ToastLabelParams {
		public let numberOfLines: Int
		
		public init(numberOfLines: Int) {
			self.numberOfLines = numberOfLines
		}
	}
}
