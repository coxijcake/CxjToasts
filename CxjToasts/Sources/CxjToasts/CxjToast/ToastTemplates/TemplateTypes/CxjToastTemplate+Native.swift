//
//  CxjToastTemplate+Native.swift
//  
//
//  Created by Nikita Begletskiy on 07/10/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct NativeToastData {
		let title: String
		let subtitle: String?
		let icon: UIImage?
		let backgroundColor: UIColor
		
		public init(
			title: String,
			subtitle: String?,
			icon: UIImage?,
			backgroundColor: UIColor
		) {
			self.title = title
			self.subtitle = subtitle
			self.icon = icon
			self.backgroundColor = backgroundColor
		}
	}
}
