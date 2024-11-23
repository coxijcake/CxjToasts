//
//  CxjToastConfiguration+Animations.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation
import UIKit.UIColor

extension CxjToastConfiguration {
	public struct Animations: Sendable {
		public let present: Animation
		public let dismiss: Animation
		
		public init(
			present: Animation,
			dismiss: Animation
		) {
			self.present = present
			self.dismiss = dismiss
		}
	}
	
	public struct Animation: Sendable {
		public enum TopPlacementNativeView: Sendable {
			case notch, dynamicIsland
		}
		
		public enum Behaviour: Sendable {
			public typealias CustomBehaviourChanges = Set<CustomBehaviourChange>
			
			public enum CustomBehaviourChange: Hashable, Sendable {
				public struct Scale: Sendable {
					let x: CGFloat
					let y: CGFloat
					
					public init(x: CGFloat, y: CGFloat) {
						self.x = x
						self.y = y
					}
				}
				
				public struct Translation: Sendable {
					let x: CGFloat
					let y: CGFloat
					
					public init(x: CGFloat, y: CGFloat) {
						self.x = x
						self.y = y
					}
				}
				
				public enum TranslationType: Sendable {
					/// won't work for .center placement toast
					case outOfSourceViewVerticaly
					case custom(value: Translation)
				}
								
				public struct CornerRadius: Sendable {
					public enum CornerRadiusType: Sendable {
						case screenCornerRadius
						case custom(value: CGFloat)
					}
					
					public enum Constraint: Sendable {
						case none
						case halfHeigt
					}
					
					let type: CornerRadiusType
					let constraint: Constraint
					
					public init (type: CornerRadiusType, constraint: Constraint = .halfHeigt) {
						self.type = type
						self.constraint = constraint
					}
				}
				
				case scale(value: Scale)
				case translation(type: TranslationType)
				case alpha(intensity: CGFloat)
				case shadowOverlay(color: UIColor, intensity: CGFloat)
				case corners(radius: CornerRadius)
				
				var compareIdentifier: String {
					switch self {
					case .scale: return "scale"
					case .translation: return "tranlsation"
					case .alpha: return "alpha"
					case .shadowOverlay: return "shadowOverlay"
					case .corners: return "corners"
					}
				}
				
				public static func == (lhs: CustomBehaviourChange, rhs: CustomBehaviourChange) -> Bool {
					lhs.compareIdentifier == rhs.compareIdentifier
				}
				
				public func hash(into hasher: inout Hasher) {
					hasher.combine(compareIdentifier)
				}
			}
			
			case `default`(includingNativeViews: Set<TopPlacementNativeView>)
			case custom(changes: CustomBehaviourChanges)
		}
		
		public let animation: CxjAnimation
		public let behaviour: Behaviour
		
		public init(
			animation: CxjAnimation,
			behaviour: Behaviour
		) {
			self.animation = animation
			self.behaviour = behaviour
		}
	}
}
