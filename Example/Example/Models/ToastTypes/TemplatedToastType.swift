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
	
	var id: String { rawValue }
	var title: String {
		switch self {
		case .native: "Native"
		case .bottomPrimary: "Bottom Primary"
		}
	}
}
