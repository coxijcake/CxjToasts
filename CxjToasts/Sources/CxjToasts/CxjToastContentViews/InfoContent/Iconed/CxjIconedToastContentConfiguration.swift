//
//  CxjIconedToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjIconedToastContentConfiguration {
	public let layout: LayoutParams
	public let iconParams: IconParams
    
	public init(
		layout: LayoutParams,
		iconParams: IconParams
	) {
		self.layout = layout
        self.iconParams = iconParams
    }
}

extension CxjIconedToastContentConfiguration {
	public struct LayoutParams {
		public enum IconPlacement {
			case left, top, right, bottom
		}
		
		public let iconPlacement: IconPlacement
		public let paddingToContent: CGFloat
		
		public init(
			iconPlacement: IconPlacement,
			paddingToContent: CGFloat
		) {
			self.iconPlacement = iconPlacement
			self.paddingToContent = paddingToContent
		}
	}
	
	public typealias IconParams = CxjIconConfiguration
}
