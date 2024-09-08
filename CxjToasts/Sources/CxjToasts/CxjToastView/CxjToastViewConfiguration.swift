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
	let cornerRadius: CGFloat
	
	public init(
		contentInsets: UIEdgeInsets,
		colors: Colors,
		shadow: Shadow,
		cornerRadius: CGFloat
	) {
		self.contentInsets = contentInsets
		self.colors = colors
		self.shadow = shadow
		self.cornerRadius = cornerRadius
	}
	
	//MARK: - Base
	static var base: CxjToastViewConfiguration {
		CxjToastViewConfiguration(
			contentInsets: UIEdgeInsets(
				top: 8,
				left: 16,
				bottom: 8,
				right: 16
			),
			colors: Colors(background: .white),
			shadow: Shadow.enable(
				params: Shadow.Params(
					offset: CGSize(width: 0, height: 4),
					color: UIColor.black.withAlphaComponent(0.18),
					opacity: 1,
					radius: 10
				)
			),
			cornerRadius: 10
		)
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
}
