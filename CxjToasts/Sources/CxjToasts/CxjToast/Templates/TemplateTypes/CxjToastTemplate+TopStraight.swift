//
//  CxjToastTemplate+TopStraight.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct TopStraightToastData {
		public struct Title {
			public let text: String
			public let textColor: UIColor
			public let font: UIFont
			
			public init(
				text: String,
				textColor: UIColor,
				font: UIFont
			) {
				self.text = text
				self.textColor = textColor
				self.font = font
			}
		}
		
		let typeId: String
		let customSourceView: UIView?
		let icon: UIImage?
		let title: Title
		let background: CxjToastViewConfiguration.Background
		
		public init(
			typeId: String,
			customSourceView: UIView?,
			icon: UIImage?,
			title: Title,
			background: CxjToastViewConfiguration.Background
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.icon = icon
			self.title = title
			self.background = background
		}
	}
}
