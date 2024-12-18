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
    public let contentMode: UIView.ContentMode
	
	public init(
		icon: UIImage,
        contentMode: UIView.ContentMode = .scaleAspectFit,
		tintColor: UIColor? = nil,
		fixedSize: CGSize?,
        cornerRadius: CGFloat? = nil
	) {
		self.icon = icon
        self.contentMode = contentMode
		self.tintColor = tintColor
		self.fixedSize = fixedSize
        self.cornerRadius = cornerRadius
	}
}
