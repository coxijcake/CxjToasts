//
//  CustomToastType.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import Foundation

enum CustomToastType: String, CaseIterable, ToastType  {
	case bottomGradientedWithBlurredBackground
    case sidePresentingToast
	
	var id: String { rawValue }
    var title: String { rawValue }
}
