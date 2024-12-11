//
//  CxjToastTemplate+BottomPrimary.swift
//
//
//  Created by Nikita Begletskiy on 07/10/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct BottomPrimaryToastData {
		public typealias Text = CxjLabelConfiguration
		public typealias Icon = CxjIconConfiguration
		
		let typeId: String
		let customSourceView: UIView?
		let icon: Icon?
		let title: Text
		let subtitle: Text?
		let background: CxjToastViewConfiguration.Background
		let shadowColor: UIColor?
		
		public init(
			typeId: String,
			customSourceView: UIView? = nil,
			icon: Icon?,
			title: Text,
			subtitle: Text?,
			background: CxjToastViewConfiguration.Background,
			shadowColor: UIColor?
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.icon = icon
			self.title = title
			self.subtitle = subtitle
			self.background = background
			self.shadowColor = shadowColor
		}
	}
}
