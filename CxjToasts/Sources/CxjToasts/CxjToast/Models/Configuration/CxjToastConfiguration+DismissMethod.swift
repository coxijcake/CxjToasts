//
//  CxjToastConfiguration+DismissMethod.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation

extension CxjToastConfiguration {
	public enum DismissMethod: Hashable, Equatable {
		public enum SwipeDirection: String, Hashable {
			case top, bottom, any
		}
		
		case tap
		case automatic(time: TimeInterval)
		case swipe(direction: SwipeDirection)
	}
}
