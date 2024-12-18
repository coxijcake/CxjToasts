//
//  TemplatedToastType.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import Foundation

enum TemplatedToastType: String, CaseIterable, ToastType {
	case native
	case bottomPrimary
	case topStraight
    case minimalizedGlobalStatus
    
	case compactAction
	case undoAction
	
	var id: String { rawValue }
	var title: String { rawValue }
}
