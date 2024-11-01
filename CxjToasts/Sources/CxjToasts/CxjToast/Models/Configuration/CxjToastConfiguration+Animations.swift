//
//  CxjToastConfiguration+Animations.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation
import UIKit.UIColor

extension CxjToastConfiguration {
	public struct Animations {
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
	
	public struct Animation {
		public enum TopPlacementNativeView {
			case notch, dynamicIsland
		}
		
		public enum Behaviour {
			public typealias CustomBehaviourChanges = Set<CustomBehaviourChange>
			
			public enum CustomBehaviourChange: Hashable {
				public struct Scale {
					let x: CGFloat
					let y: CGFloat
					
					public init(x: CGFloat, y: CGFloat) {
						self.x = x
						self.y = y
					}
				}
				
				public struct Translation {
					let x: CGFloat
					let y: CGFloat
					
					public init(x: CGFloat, y: CGFloat) {
						self.x = x
						self.y = y
					}
				}
				
				public enum TranslationType {
					/// won't work for .center placement toast
					case outOfSourceViewVerticaly
					case custom(value: Translation)
				}
								
				public struct CornerRadius {
					public enum CornerRadiusType {
						case screenCornerRadius
						case custom(value: CGFloat)
					}
					
					public enum Constraint {
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
					case .scale(let value): return "scale"
					case .translation(let value): return "tranlsation"
					case .alpha(let intensity): return "alpha"
					case .shadowOverlay(let intensity): return "shadowOverlay"
					case .corners(let radius): return "corners"
					}
				}
				
				public static func == (lhs: CustomBehaviourChange, rhs: CustomBehaviourChange) -> Bool {
					lhs.compareIdentifier == rhs.compareIdentifier
				}
				
				public func hash(into hasher: inout Hasher) {
					hasher.combine(compareIdentifier)
				}
			}
			
			case `default`
			case custom(changes: CustomBehaviourChanges)
		}
		
		public let animation: CxjAnimation
		public let behaviour: Behaviour
		public let nativeViewsIncluding: Set<TopPlacementNativeView>
		
		public init(
			animation: CxjAnimation,
			behaviour: Behaviour,
			nativeViewsIncluding: Set<TopPlacementNativeView>
		) {
			self.animation = animation
			self.behaviour = behaviour
			self.nativeViewsIncluding = nativeViewsIncluding
		}
	}
}
