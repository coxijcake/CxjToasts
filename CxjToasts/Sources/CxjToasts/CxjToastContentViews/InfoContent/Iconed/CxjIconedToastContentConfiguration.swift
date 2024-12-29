//
//  CxjIconedToastContentConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

/// Configuration for a toast content layout that includes an icon.
///
/// Use this structure to define the layout and appearance of a toast that features an icon alongside other content.
public struct CxjIconedToastContentConfiguration {
	
	/// Layout parameters for the icon and content.
	public let layout: LayoutParams
	
	/// Parameters defining the icon's appearance and behavior.
	public let iconParams: CxjIconConfiguration
	
	/// Initializes the configuration for an iconed toast content.
	///
	/// - Parameters:
	///   - layout: Layout parameters for positioning the icon relative to the content.
	///   - iconParams: Configuration for the icon's appearance and size.
	public init(
		layout: LayoutParams,
		iconParams: CxjIconConfiguration
	) {
		self.layout = layout
		self.iconParams = iconParams
	}
}

extension CxjIconedToastContentConfiguration {
	
	/// Layout parameters for positioning the icon in the toast content.
	public struct LayoutParams {
		
		/// Specifies the position of the icon relative to the content.
		public enum IconPlacement {
			/// Icon is positioned to the left of the content.
			case left
			
			/// Icon is positioned above the content.
			case top
			
			/// Icon is positioned to the right of the content.
			case right
			
			/// Icon is positioned below the content.
			case bottom
		}
		
		/// The placement of the icon relative to the content.
		public let iconPlacement: IconPlacement
		
		/// The padding between the icon and the content.
		public let paddingToContent: CGFloat
		
		/// Initializes the layout parameters for the icon.
		///
		/// - Parameters:
		///   - iconPlacement: The position of the icon relative to the content.
		///   - paddingToContent: The spacing between the icon and the content.
		public init(
			iconPlacement: IconPlacement,
			paddingToContent: CGFloat
		) {
			self.iconPlacement = iconPlacement
			self.paddingToContent = paddingToContent
		}
	}
}
