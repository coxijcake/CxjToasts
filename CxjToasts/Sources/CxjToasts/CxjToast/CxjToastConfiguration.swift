//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

//MARK: - Configuration
public struct CxjToastConfiguration {
    let constraints: Constraints
    let placement: Placement
    let hidingMethods: Set<HidingMethod>
    let presentAnimation: Animation
    let dismissAnimation: Animation
    
    public init(
        constraints: Constraints,
        placement: Placement,
        hidingMethods: Set<HidingMethod>,
        presentAnimation: Animation,
        dismissAnimation: Animation
    ) {
        self.constraints = constraints
        self.placement = placement
        self.hidingMethods = hidingMethods
        self.presentAnimation = presentAnimation
        self.dismissAnimation = dismissAnimation
    }
}

extension CxjToastConfiguration {
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
    
    //MARK: - Placement
    public enum Placement {
        case top, center, bottom
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
    
    //MARK: - Animation
    public struct Animation {
        public enum AnimationType {
            case `default`
        }
        
        let type: AnimationType
        let duration: TimeInterval
    }
}
