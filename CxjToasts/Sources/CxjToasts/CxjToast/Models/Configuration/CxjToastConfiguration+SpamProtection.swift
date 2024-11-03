//
//  CxjToastConfiguration+SpamProtection.swift
//
//
//  Created by Nikita Begletskiy on 02/11/2024.
//

import Foundation

extension CxjToastConfiguration {
	public enum ToastComparingAttribute: Hashable {
		case type
		case placement(includingYOffset: Bool)
	}
	
	public enum SpamProtection {
		case on(comparingAttributes: Set<ToastComparingAttribute>)
		case off
	}
}


extension CxjToastConfiguration {
	public struct DisplayingBehaviour {
		public enum Action {
			case stack(maxVisibleToasts: Int)
			case hide
			case dismiss
		}
		
		
		let action: Action
		let comparingAttributes: Set<ToastComparingAttribute>
		
		public init(
			handling: Action,
			comparingAttributes: Set<ToastComparingAttribute> = [
				.type,
				.placement(includingYOffset: true)
			]
		) {
			self.action = handling
			self.comparingAttributes = comparingAttributes
		}
	}
}
