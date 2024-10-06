//
//  CxjUIViewShadowParams.swift
//  
//
//  Created by Nikita Begletskiy on 06/10/2024.
//

import UIKit

public struct CxjUIViewShadowParams {
	let offset: CGSize
	let color: UIColor
	let opacity: Float
	let radius: CGFloat
	
	public init(
		offset: CGSize,
		color: UIColor,
		opacity: Float,
		radius: CGFloat
	) {
		self.offset = offset
		self.color = color
		self.opacity = opacity
		self.radius = radius
	}
}

extension UIView {
	func setupShadowWithParams(_ cxjShadowParams: CxjUIViewShadowParams) {
		layer.masksToBounds = false
		layer.shadowOffset = cxjShadowParams.offset
		layer.shadowColor = cxjShadowParams.color.cgColor
		layer.shadowOpacity = cxjShadowParams.opacity
		layer.shadowRadius = cxjShadowParams.radius
	}
}
