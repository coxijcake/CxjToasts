//
//  CxjToastTemplate+Native.swift
//  
//
//  Created by Nikita Begletskiy on 07/10/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct NativeToastData {
		public typealias Text = CxjTextConfiguration
		
		let typeId: String
		let title: Text
		let subtitle: Text?
		let icon: UIImage?
		let backgroundColor: UIColor
		let hapticFeeback: CxjHapticFeedback?
		
		public init(
			typeId: String,
			title: Text,
			subtitle: Text?,
			icon: UIImage?,
			backgroundColor: UIColor,
			hapticFeeback: CxjHapticFeedback?
		) {
			self.typeId = typeId
			self.title = title
			self.subtitle = subtitle
			self.icon = icon
			self.backgroundColor = backgroundColor
			self.hapticFeeback = hapticFeeback
		}
	}
}
