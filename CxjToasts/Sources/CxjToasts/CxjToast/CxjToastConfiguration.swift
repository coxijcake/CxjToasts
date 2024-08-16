//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public struct CxjToastConfiguration {
    let constraints: Constraints
    let placement: Placement
    let hidingMethod: HidingMethod
    let presentAnimation: Animation
    let dismissAnimation: Animation
    
    public init(
        constraints: Constraints,
        placement: Placement,
        hidingMethod: HidingMethod,
        presentAnimation: Animation,
        dismissAnimation: Animation
    ) {
        self.constraints = constraints
        self.placement = placement
        self.hidingMethod = hidingMethod
        self.presentAnimation = presentAnimation
        self.dismissAnimation = dismissAnimation
    }
}

extension CxjToastConfiguration {
    public struct Constraints {
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
    
    public enum Placement {
        case top, center, bottom
    }
    
    public enum HidingMethod: String, Hashable, Equatable {
        public enum SwipeDirection {
            case top, bottom, any
        }
        
        case tap
        case automatic(time: TimeInterval)
        case swipe(direction: SwipeDirection)
    }
    
    public struct Animation {
        public enum AnimationType {
            case `default`
        }
        
        let type: AnimationType
        let duration: TimeInterval
    }
}
