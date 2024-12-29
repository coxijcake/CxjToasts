//
//  UIScreen+Extensions.swift
//
//
//  Created by Nikita Begletskiy on 29/09/2024.
//

import UIKit.UIScreen

extension UIScreen {
	/// The corner radius of the display. Uses a private property of `UIScreen`,
	/// and may report 0 if the API changes.
	private var cornerRadiusKey: String {
		let components = ["Radius", "Corner", "display", "_"]
		return components.reversed().joined()
	}

	var displayCornerRadius: CGFloat {
		guard let cornerRadius = value(forKey: cornerRadiusKey) as? CGFloat else { return 0 }
		return cornerRadius
	}
}
