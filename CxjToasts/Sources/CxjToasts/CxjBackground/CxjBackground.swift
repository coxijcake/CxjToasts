//
//  CxjBackground.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

public enum CxjBackground {
	case colorized(color: UIColor)
	case blurred(effect: UIBlurEffect)
	case gradient(params: CxjGradientParams)
	case custom(view: UIView)
}
