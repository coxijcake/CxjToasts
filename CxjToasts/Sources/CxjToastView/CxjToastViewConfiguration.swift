//
//  CxjToastViewConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit


/// Configuration structure for a toast view, defining its appearance, layout, and interaction behavior.
public struct CxjToastViewConfiguration {
	/// The layout of the content within the toast view. Determines whether the content fills the view with insets
	/// or is constrained by specific anchors.
	public let contentLayout: ContentLayout
	
	/// The background configuration for the toast view, such as a solid color, blur effect, gradient, or custom view.
	public let background: Background
	
	/// Shadow configuration for the toast view, enabling or disabling shadows with customizable parameters.
	public let shadow: Shadow
	
	/// Corner configuration for the toast view, supporting rounded, capsule, or custom styles.
	public let corners: Corners
	
	/// Indicates whether user interactions with the toast view are enabled.
	public let isUserInteractionEnabled: Bool
	
	/// Initializes the toast view configuration with the provided parameters.
	///
	/// - Parameters:
	///   - contentLayout: The layout configuration for the toast content.
	///   - background: The background style for the toast.
	///   - shadow: The shadow configuration for the toast view.
	///   - corners: The corner style for the toast view.
	///   - isUserInteractionEnabled: Whether user interactions with the toast view are enabled.
	public init(
		contentLayout: ContentLayout,
		background: Background,
		shadow: Shadow,
		corners: Corners,
		isUserInteractionEnabled: Bool
	) {
		self.contentLayout = contentLayout
		self.background = background
		self.shadow = shadow
		self.corners = corners
		self.isUserInteractionEnabled = isUserInteractionEnabled
	}
}

public extension CxjToastViewConfiguration {
	typealias Background = CxjBackground
	typealias ContentLayout = CxjToastContentLayout
	
	//MARK: - Shadow
	/// Configuration for enabling or disabling shadows on the toast view.
	enum Shadow {
		/// Enables shadow with customizable parameters such as offset, color, opacity, and radius.
		case enable(params: CxjUIViewShadowParams)
		
		/// Disables shadow for the toast view.
		case disable
	}
	
	//MARK: - Corners
	/// Configuration for the corner style of the toast view, supporting various masking options.
	enum Corners {
		/// Different masking options for corners.
		public enum CornersMask {
			/// No corners are rounded.
			case none
			
			/// Only the top corners are rounded.
			case top
			
			/// Only the bottom corners are rounded.
			case bottom
			
			/// Only the left corners are rounded.
			case left
			
			/// Only the right corners are rounded.
			case right
			
			/// All corners are rounded.
			case all
			
			/// Custom corners defined by a `CACornerMask`.
			case custom(mask: CACornerMask)
			
			/// Converts the mask to a `CACornerMask` that can be applied to a layer.
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
				case .all:
					[
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
		
		/// Straight corners with the specified mask.
		case straight(mask: CornersMask)
		
		/// Capsule corners with the specified mask.
		/// The corner radius will be automatically calculated as half the height of the view
		case capsule(mask: CornersMask)
		
		/// Fixed corner radius with the specified value and mask.
		case fixed(value: CGFloat, mask: CornersMask)
		
		/// Returns the corner mask for the corner style.
		public var mask: CornersMask {
			switch self {
			case .straight(let mask): mask
			case .capsule(let mask): mask
			case .fixed(_, let mask): mask
			}
		}
	}
}
