//
//  CxjToastConfiguration+SpamProtection.swift
//
//
//  Created by Nikita Begletskiy on 02/11/2024.
//

import Foundation

extension CxjToastConfiguration {
	public enum ToastComparingAttribute: Hashable, Sendable {
		case type
		case placement(includingYOffset: Bool)
		case sourceView
	}
	
	public enum SpamProtection: Sendable {
		case on(comparingAttributes: Set<ToastComparingAttribute>)
		case off
	}
}


extension CxjToastConfiguration {
	public struct DisplayingBehaviour: Sendable {
		public enum Action: Sendable {
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
				.placement(includingYOffset: true),
				.sourceView
			]
		) {
			self.action = handling
			self.comparingAttributes = comparingAttributes
		}
	}
}
