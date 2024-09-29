//
//  CxjToastConfiguration+Animations.swift
//
//
//  Created by Nikita Begletskiy on 25/09/2024.
//

import Foundation

extension CxjToastConfiguration {
	public struct Animations {
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
					
					public init (type: CornerRadiusType, constraint: Constraint) {
						self.type = type
						self.constraint = constraint
					}
				}
				
				case scale(value: Scale)
				case translation(value: Translation)
				case alpha(intensity: CGFloat)
				case shadow(intensity: CGFloat)
				case corners(radius: CornerRadius)
				
				var compareIdentifier: String {
					switch self {
					case .scale(let value): return "scale"
					case .translation(let value): return "tranlsation"
					case .alpha(let intensity): return "alpha"
					case .shadow(let intensity): return "shadow"
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
		
		let present: CxjAnimation
		let dismiss: CxjAnimation
		let behaviour: Behaviour
		let nativeViewsIncluding: Set<TopPlacementNativeView>
		
		public init(
			present: CxjAnimation,
			dismiss: CxjAnimation,
			behaviour: Behaviour,
			nativeViewsIncluding: Set<TopPlacementNativeView>
		) {
			self.present = present
			self.dismiss = dismiss
			self.behaviour = behaviour
			self.nativeViewsIncluding = nativeViewsIncluding
		}
	}
}
