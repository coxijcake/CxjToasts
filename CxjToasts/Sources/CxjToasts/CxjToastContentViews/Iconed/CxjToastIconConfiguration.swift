//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit


public enum CxjToastIconConfiguration {	
	public struct IconParams {
		public let icon: UIImage
		public let tintColor: UIColor?
		
		public init(
			icon: UIImage,
			tintColor: UIColor?
		) {
			self.icon = icon
			self.tintColor = tintColor
		}
	}
}
