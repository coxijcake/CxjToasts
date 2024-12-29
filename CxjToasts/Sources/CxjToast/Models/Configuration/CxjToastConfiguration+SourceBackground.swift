//
//  CxjToastConfiguration+SourceBackground.swift
//
//
//  Created by Nikita Begletskiy on 29/10/2024.
//

import UIKit

extension CxjToastConfiguration {
	public struct SourceBackground: Sendable {
		public typealias Theme = CxjToastSourceBackgroundTheme
		public typealias CustomActionHandlingCompletion = @Sendable (any CxjIdentifiableToast) -> Void
		
		public enum Interaction: Sendable {
			case disabled
			case enabled(action: Action?)
		}
		
		public struct Action: Sendable {
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
		
		public enum ActionHandling: Sendable {
			case none
			case dismissToast
			case custom(completion: CustomActionHandlingCompletion?)
		}
		
		public let theme: Theme
		public let interaction: Interaction
		
		public init(
			theme: Theme,
			interaction: Interaction
		) {
			self.theme = theme
			self.interaction = interaction
		}
	}
}
