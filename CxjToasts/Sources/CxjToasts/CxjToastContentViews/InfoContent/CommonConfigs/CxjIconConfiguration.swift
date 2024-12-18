//
//  CxjIconConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/12/2024.
//

import UIKit

public struct CxjIconConfiguration {
	public let icon: UIImage
	public let tintColor: UIColor?
	public let fixedSize: CGSize?
    public let cornerRadius: CGFloat?
	
	public init(
		icon: UIImage,
		tintColor: UIColor? = nil,
		fixedSize: CGSize?,
        cornerRadius: CGFloat? = nil
	) {
		self.icon = icon
		self.tintColor = tintColor
		self.fixedSize = fixedSize
        self.cornerRadius = cornerRadius
	}
}
