//
//  UIColor+Extensions.swift
//  Example
//
//  Created by Nikita Begletskiy on 25/12/2024.
//

import UIKit

extension UIColor {
	static func fromFigmaRgb(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
		UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
	}
}
