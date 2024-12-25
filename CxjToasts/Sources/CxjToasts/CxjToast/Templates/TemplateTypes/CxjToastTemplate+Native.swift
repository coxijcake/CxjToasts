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
		public typealias Icon = CxjIconConfiguration
		public typealias Background = CxjBackground
		public typealias Shadow = CxjToastViewConfiguration.Shadow
		
		let typeId: String
		let title: Text
		let subtitle: Text?
		let icon: Icon?
		let background: Background
		let shadow: Shadow
		let hapticFeeback: CxjHapticFeedback?
		
		public init(
			typeId: String,
			title: Text,
			subtitle: Text?,
			icon: Icon?,
			background: Background,
			shadow: Shadow,
			hapticFeeback: CxjHapticFeedback?
		) {
			self.typeId = typeId
			self.title = title
			self.subtitle = subtitle
			self.icon = icon
			self.background = background
			self.shadow = shadow
			self.hapticFeeback = hapticFeeback
		}
	}
}
