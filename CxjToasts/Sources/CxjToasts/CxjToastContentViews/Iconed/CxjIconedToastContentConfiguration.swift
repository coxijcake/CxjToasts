//
//  CxjIconedToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjIconedToastContentConfiguration {
	public let params: LayoutParams
	public let iconParams: IconParams
    
	public init(
		params: LayoutParams,
		iconParams: IconParams
	) {
		self.params = params
        self.iconParams = iconParams
    }
}

extension CxjIconedToastContentConfiguration {
	public struct LayoutParams {
		public enum IconPlacement {
			case left, top, right, bottom
		}
		
		public let iconPlacement: IconPlacement
		public let paddingToTitle: CGFloat
		
		public init(
			iconPlacement: IconPlacement,
			paddingToTitle: CGFloat
		) {
			self.iconPlacement = iconPlacement
			self.paddingToTitle = paddingToTitle
		}
	}
	
    public struct IconParams {
        public let icon: UIImage
        public let tintColor: UIColor?
		public let fixedSize: CGSize?
		
        public init(
            icon: UIImage,
            tintColor: UIColor? = nil,
			fixedSize: CGSize?
        ) {
            self.icon = icon
            self.tintColor = tintColor
			self.fixedSize = fixedSize
        }
    }
}
