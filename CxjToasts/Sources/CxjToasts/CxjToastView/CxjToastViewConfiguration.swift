//
//  CxjToastViewConfiguration.swift
//  
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public struct CxjToastViewConfiguration {
	public typealias Background = CxjBackground
    public typealias ContentLayout = CxjToastContentLayout
	
	public let background: Background
    public let contentLayout: ContentLayout
	public let shadow: Shadow
	public let corners: Corners
	
	public init(
        contentLayout: ContentLayout,
		background: Background,
		shadow: Shadow,
		corners: Corners
	) {
        self.contentLayout = contentLayout
		self.background = background
		self.shadow = shadow
		self.corners = corners
	}
}

public extension CxjToastViewConfiguration {
	//MARK: - Shadow
	enum Shadow {
		case enable(params: CxjUIViewShadowParams)
		case disable
	}
	
	//MARK: - Corners
	enum Corners {
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
			case .fixed(_, let mask): mask
			}
		}
	}
}
