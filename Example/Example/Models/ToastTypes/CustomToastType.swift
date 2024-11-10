//
//  CustomToastType.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import Foundation

enum CustomToastType: String, CaseIterable, ToastType  {
	case bottomGradientedWithBlurredBackground
	
	var id: String { rawValue }
	var title: String {
		switch self {
		case .bottomGradientedWithBlurredBackground:
			"Bottom Gradiented content with blurred background"
		}
	}
}
