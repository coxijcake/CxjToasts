//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjToastViewConfiguration {
	let constraints: Constraints
	let colors: Colors
	let shadow: Shadow
	let cornerRadius: CGFloat
}

public extension CxjToastViewConfiguration {
	public struct Constraints {
		let width: ConstraintValues
		let height: ConstraintValues
		
		public init(
			width: ConstraintValues,
			height: ConstraintValues
		) {
			self.width = width
			self.height = height
		}
	}
	
	public struct ConstraintValues {
		let min: CGFloat
		let max: CGFloat
		
		public init(
			min: CGFloat,
			max: CGFloat
		) {
			self.min = min
			self.max = max
		}
	}
	
	public enum Shadow {
		public struct Params {
			let offset: CGSize
			let color: UIColor
			let opacity: CGFloat
			let radius: CGFloat
			
			public init(
				offset: CGSize,
				color: UIColor,
				opacity: CGFloat,
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
	}
}
