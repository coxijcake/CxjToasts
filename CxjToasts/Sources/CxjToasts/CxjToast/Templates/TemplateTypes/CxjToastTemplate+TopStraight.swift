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
        public typealias Background = CxjToastViewConfiguration.Background
        public typealias Shadow = CxjToastViewConfiguration.Shadow
		
		public let typeId: String
		public let customSourceView: UIView?
		public let icon: UIImage?
		public let title: Title
        public let background: Background
        public let shadow: Shadow
        
		public init(
			typeId: String,
			customSourceView: UIView?,
			icon: UIImage?,
			title: Title,
			background: Background,
            shadow: Shadow
		) {
			self.typeId = typeId
			self.customSourceView = customSourceView
			self.icon = icon
			self.title = title
            self.background = background
            self.shadow = shadow
		}
	}
}
