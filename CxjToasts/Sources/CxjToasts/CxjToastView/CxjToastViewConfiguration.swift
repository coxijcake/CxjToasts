//
//  File.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjToastViewConfiguration {
	public let background: Background
	public let contentInsets: UIEdgeInsets
	public let shadow: Shadow
	public let corners: Corners
	
	public init(
		contentInsets: UIEdgeInsets,
		background: Background,
		shadow: Shadow,
		corners: Corners
	) {
		self.contentInsets = contentInsets
		self.background = background
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
	
	//MARK: - Background
	public enum Background {
		case colorized(color: UIColor)
		case blurred(effect: UIBlurEffect)
		case gradient(params: CxjGradientParams)
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
			
			public var layerMask: CACornerMask {
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
		case fixed(value: CGFloat, mask: CornersMask)
		
		public var mask: CornersMask {
			switch self {
			case .straight(let mask): mask
			case .capsule(let mask): mask
			case .fixed(let value, let mask): mask
			}
		}
	}
}
