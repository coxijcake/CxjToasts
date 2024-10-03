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
		
		
		case tap(actionCompletion: (() -> Void)?)
		case automatic(time: TimeInterval)
		case swipe(direction: SwipeDirection)
		
		var compareIdentifier: String {
			switch self {
			case .tap(let actionCompletion): "tap" + (actionCompletion == nil ? "" : "action")
			case .automatic(let time): "automatic \(time)"
			case .swipe(let direction): "swipe \(direction.rawValue)"
			}
		}
		
		public static func == (lhs: CxjToastConfiguration.DismissMethod, rhs: CxjToastConfiguration.DismissMethod) -> Bool {
			lhs.compareIdentifier == rhs.compareIdentifier
		}
		
		public func hash(into hasher: inout Hasher) {
			hasher.combine(compareIdentifier)
		}
	}
}
