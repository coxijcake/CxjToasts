//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Configuration
public struct CxjToastConfiguration {
    let layout: Layout
    let hidingMethods: Set<HidingMethod>
	let animations: Animations
    
    let sourceView: UIView
    
    public init(
        layout: Layout,
        hidingMethods: Set<HidingMethod>,
		animations: Animations,
        sourceView: UIView
    ) {
        self.layout = layout
        self.hidingMethods = hidingMethods
        self.animations = animations
        self.sourceView = sourceView
    }
}

extension CxjToastConfiguration {
    //MARK: - Layout
    public struct Layout {
		public enum Placement {
			case top, center, bottom
		}
		
        let constraints: Constraints
        let placement: Placement
        
        public init(
            constraints: Constraints,
            placement: Placement
        ) {
            self.constraints = constraints
            self.placement = placement
        }
    }
    
    //MARK: - Constraints
    public struct Constraints {
        public struct ConstraintValues {
            let min: CGFloat
            let max: CGFloat
            
            public init(
                min: CGFloat,
                max: CGFloat
            ) {
                self.min = min
                self.max = max
            }
        }
        
        let width: ConstraintValues
        let height: ConstraintValues
        
        public init(
            width: ConstraintValues,
            height: ConstraintValues
        ) {
            self.width = width
            self.height = height
        }
    }
    
    //MARK: - HidingMethod
    public enum HidingMethod: Hashable, Equatable {
        public enum SwipeDirection: String, Hashable {
            case top, bottom, any
        }
        
        case tap
        case automatic(time: TimeInterval)
        case swipe(direction: SwipeDirection)
    }
    
    //MARK: - Animations
	public struct Animations {
		public struct Animation {
			public enum AnimationType {
				case `default`
			}
			
			let type: AnimationType
//			let duration: TimeInterval
			let animator: CxjAnimator
		}
		
		let present: Animation
		let dismiss: Animation
	}
}
