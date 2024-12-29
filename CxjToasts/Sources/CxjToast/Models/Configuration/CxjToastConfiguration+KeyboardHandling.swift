//
//  CxjToastConfiguration+KeyboardHandling.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import Foundation

extension CxjToastConfiguration {
	public enum KeyboardHandling: Sendable {
		case ignore
		
		/// Works only if source view safe area == Key Window safe area
		/// and toast maxY lower than keyboard
		/// additional offset - vertical padding from keyboard to toast
		case moveToastUpperKeyboard(additionalOffset: CGFloat)
	}
}
