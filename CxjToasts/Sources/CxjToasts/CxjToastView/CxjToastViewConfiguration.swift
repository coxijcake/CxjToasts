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
	//MARK: - Shadow
	public enum Shadow {
		case enable(params: CxjUIViewShadowParams)
		case disable
	}
	
	//MARK: - Colors
	public struct Colors {
		let background: UIColor
		
		public init(
			background: UIColor
		) {
			self.background = background
		}
	}
	
	//MARK: - Corners
	public enum Corners {
		public enum CornersMask {
			case none
			case top
			case bottom
			case left
			case right
			case all
			case custom(mask: CACornerMask)
			
			var layerMask: CACornerMask {
				switch self {
				case .none:
					[]
				case .top:
					[
						.layerMinXMinYCorner,
						.layerMaxXMinYCorner
					]
				case .bottom:
					[
						.layerMinXMaxYCorner,
						.layerMaxXMaxYCorner
					]
				case .left:
					[
						.layerMinXMinYCorner,
						.layerMinXMaxYCorner
					]
				case .right:
					[
						.layerMaxXMinYCorner,
						.layerMaxXMaxYCorner
					]
				case .all: [
					.layerMinXMinYCorner,
					.layerMaxXMinYCorner,
					.layerMinXMaxYCorner,
					.layerMaxXMaxYCorner
				]
				case .custom(let mask):
					mask
				}
			}
		}
		
		case straight(mask: CornersMask)
		case capsule(mask: CornersMask)
		case rounded(value: CGFloat, mask: CornersMask)
		
		var mask: CornersMask {
			switch self {
			case .straight(let mask): mask
			case .capsule(let mask): mask
			case .rounded(let value, let mask): mask
			}
		}
	}
}
