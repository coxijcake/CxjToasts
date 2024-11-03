////
////  CxjToastsSettings.swift
////
////
////  Created by Nikita Begletskiy on 01/11/2024.
////
//
//import Foundation
//
////MARK: - Types
//extension CxjToastsSettings {
//	public enum ApplyingStrategy {
//		case all
//		case compare(attributes: Set<ComparingAttribute>)
//	}
//	
//	public enum ComparingAttribute: Equatable, Hashable {
//		case config
//		case typeId
//		case typeIds(values: Set<String>) // ?? Maybe need to remove with all type id's
//		case placement(includinValue: String)
//	}
//	
//	public struct ActiveToastsDisplaying {
//		public enum Behaviour {
//			case stack(visibleCount: Int)
//			case hide
//			case dismiss
//		}
//		
//		let behaviour: Behaviour
//		let strategy: ApplyingStrategy
//		
//		public init(
//			behavious: Behaviour,
//			strategy: ApplyingStrategy
//		) {
//			self.behaviour = behavious
//			self.strategy = strategy
//		}
//	}
//	
//	public struct SpamPreventing {
//		let strategy: ApplyingStrategy
//		
//		public init(
//			strategy: ApplyingStrategy
//		) {
//			self.strategy = strategy
//		}
//	}
//}
//
////MARK: - Settings
//public final class CxjToastsSettings {
//	private init() {}
//	static let shared: CxjToastsSettings = CxjToastsSettings()
//	
//	var spamPreventing: SpamPreventing = SpamPreventing(
//		strategy: .compare(
//			attributes: [
//				.config
//			]
//		)
//	)
//}
