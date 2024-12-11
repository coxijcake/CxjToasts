//
//  CxjToastTemplate+TopStraight.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

extension CxjToastTemplate {
	public struct TopStraightToastData {
		public typealias Title = CxjTextConfiguration
		
		public let typeId: String
		public let customSourceView: UIView?
		public let icon: UIImage?
		public let title: Title
		public let background: CxjToastViewConfiguration.Background
		
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
