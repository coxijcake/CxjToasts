//
//  CxjToastTemplate+BottomPrimary.swift
//
//
//  Created by Nikita Begletskiy on 07/10/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct BottomPrimaryToastData {
		public struct Title {
			let text: String
			let numberOfLines: Int
			let textColor: UIColor
			let font: UIFont
			
			public init(
				text: String,
				numberOfLines: Int,
				textColor: UIColor,
				font: UIFont
			) {
				self.text = text
				self.numberOfLines = numberOfLines
				self.textColor = textColor
				self.font = font
			}
		}
		
		let customSourceView: UIView?
		let icon: UIImage?
		let title: Title
		let subtitle: Title?
		let backgroundColor: UIColor
		let shadowColor: UIColor?
		
		public init(
			customSourceView: UIView? = nil,
			icon: UIImage?,
			title: Title,
			subtitle: Title?,
			backgroundColor: UIColor,
			shadowColor: UIColor?
		) {
			self.customSourceView = customSourceView
			self.icon = icon
			self.title = title
			self.subtitle = subtitle
			self.backgroundColor = backgroundColor
			self.shadowColor = shadowColor
		}
	}
}
