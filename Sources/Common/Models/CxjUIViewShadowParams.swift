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

extension CALayer {
	public func setupShadowWithParams(_ cxjShadowParams: CxjUIViewShadowParams) {
		masksToBounds = false
		shadowOffset = cxjShadowParams.offset
		shadowColor = cxjShadowParams.color.cgColor
		shadowOpacity = cxjShadowParams.opacity
		shadowRadius = cxjShadowParams.radius
	}
}

extension UIView {
	public func setupShadowWithParams(_ cxjShadowParams: CxjUIViewShadowParams) {
		layer.setupShadowWithParams(cxjShadowParams)
	}
}
