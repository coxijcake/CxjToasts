//
//  CxjToastSourceBackgroundTheme.swift
//
//
//  Created by Nikita Begletskiy on 31/10/2024.
//

import UIKit

public enum CxjToastSourceBackgroundTheme {
	case colorized(color: UIColor)
	case blurred(effect: UIBlurEffect)
	case gradient(params: CxjGradientParams)
	case custom(view: UIView)
}
