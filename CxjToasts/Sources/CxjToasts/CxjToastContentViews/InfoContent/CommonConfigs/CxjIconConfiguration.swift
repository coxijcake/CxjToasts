//
//  CxjIconConfiguration.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/12/2024.
//

import UIKit

/// Configuration for an icon displayed in a toast.
///
/// Use this structure to define the appearance and behavior of an icon,
/// including its image, size, corner radius, and color properties.
public struct CxjIconConfiguration {
	
	/// The icon image to be displayed.
	public let icon: UIImage
	
	/// The tint color applied to the icon image, if applicable.
	///
	/// - Note: If `tintColor` is `nil`, the icon is displayed in its original color.
	public let tintColor: UIColor?
	
	/// The fixed size of the icon.
	///
	/// - Note: If `fixedSize` is `nil`, the icon will adjust its size based on the container's layout.
	public let fixedSize: CGSize?
	
	/// The corner radius applied to the icon, if any.
	///
	/// - Note: If `cornerRadius` is `nil`, the icon will not have rounded corners.
	public let cornerRadius: CGFloat?
	
	/// The content mode for displaying the icon.
	///
	/// Determines how the icon image is scaled or positioned within its bounds.
	public let contentMode: UIView.ContentMode
	
	/// Initializes the configuration for an icon.
	///
	/// - Parameters:
	///   - icon: The image to be displayed as the icon.
	///   - contentMode: The mode used to scale or position the icon image. Default is `.scaleAspectFit`.
	///   - tintColor: The tint color for the icon. Default is `nil`.
	///   - fixedSize: The fixed size of the icon. Default is `nil`.
	///   - cornerRadius: The corner radius for the icon. Default is `nil`.
	public init(
		icon: UIImage,
		contentMode: UIView.ContentMode = .scaleAspectFit,
		tintColor: UIColor? = nil,
		fixedSize: CGSize?,
		cornerRadius: CGFloat? = nil
	) {
		self.icon = icon
		self.contentMode = contentMode
		self.tintColor = tintColor
		self.fixedSize = fixedSize
		self.cornerRadius = cornerRadius
	}
}
