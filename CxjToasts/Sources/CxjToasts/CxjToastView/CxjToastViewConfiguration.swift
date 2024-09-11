//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjToastViewConfiguration {
	let contentInsets: UIEdgeInsets
	let colors: Colors
	let shadow: Shadow
	let corners: Corners
	
	public init(
		contentInsets: UIEdgeInsets,
		colors: Colors,
		shadow: Shadow,
		corners: Corners
	) {
		self.contentInsets = contentInsets
		self.colors = colors
		self.shadow = shadow
		self.corners = corners
	}
}

public extension CxjToastViewConfiguration {
	public enum Shadow {
		public struct Params {
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
		
		case enable(params: Params)
		case disable
	}
	
	public struct Colors {
		let background: UIColor
		
		public init(
			background: UIColor
		) {
			self.background = background
		}
	}
	
	public enum Corners {
		case straight
		case capsule
		case rounded(value: CGFloat)
	}
}
