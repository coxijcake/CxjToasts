//
//  CxjToastConfiguration+SourceBackground.swift
//
//
//  Created by Nikita Begletskiy on 29/10/2024.
//

import UIKit

extension CxjToastConfiguration {
	public struct SourceBackground {
		public typealias CustomActionHandlingCompletion = (any CxjIdentifiableToast) -> Void
		
		public enum Interaction {
			case disabled
			case enabled(action: Action?)
		}
		
		public struct Action {
			public let touchEvent: UIControl.Event
			public let handling: ActionHandling
			
			public init(
				touchEvent: UIControl.Event,
				handling: ActionHandling
			) {
				self.touchEvent = touchEvent
				self.handling = handling
			}
		}
		
		public enum ActionHandling {
			case none
			case dismissToast
			case custom(completion: CustomActionHandlingCompletion?)
		}
		
		public let theme: CxjBackground
		public let interaction: Interaction
		
		public init(
			theme: CxjBackground,
			interaction: Interaction
		) {
			self.theme = theme
			self.interaction = interaction
		}
	}
}
