//
//  CxjToastTemplate+BottomPrimary.swift
//
//
//  Created by Nikita Begletskiy on 07/10/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct BottomPrimaryToastData {
		public typealias Label = CxjLabelConfiguration
		public typealias Icon = CxjIconConfiguration
		public typealias DismissMethods = Set<CxjToastConfiguration.DismissMethod>
		public typealias SourceBackground = CxjToastConfiguration.SourceBackground
		public typealias Shadow = CxjUIViewShadowParams
		
		let typeId: String
		let customSourceView: UIView?
		let sourceBackground: SourceBackground?
		let icon: Icon?
		let title: Label
		let subtitle: Label?
		let background: CxjToastViewConfiguration.Background
		let shadow: Shadow?
		let dismissMethods: DismissMethods
		let hapticFeeback: CxjHapticFeedback?
		
		public init(
			typeId: String,
			customSourceView: UIView? = nil,
			sourceBackground: SourceBackground?,
			icon: Icon?,
			title: Label,
			subtitle: Label?,
			background: CxjToastViewConfiguration.Background,
			shadow: Shadow?,
			dismissMethods: DismissMethods,
			hapticFeeback: CxjHapticFeedback?
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.sourceBackground = sourceBackground
			self.icon = icon
			self.title = title
			self.subtitle = subtitle
			self.background = background
			self.shadow = shadow
			self.dismissMethods = dismissMethods
			self.hapticFeeback = hapticFeeback
		}
	}
}
