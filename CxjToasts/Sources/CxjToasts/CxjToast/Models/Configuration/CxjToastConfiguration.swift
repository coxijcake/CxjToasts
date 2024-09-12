//
//  CxjToastConfiguration.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Configuration
public struct CxjToastConfiguration {
	let sourceView: UIView
    let layout: Layout
    let dismissMethods: Set<DismissMethod>
	let animations: Animations
    
    public init(
		sourceView: UIView,
        layout: Layout,
        dismissMethods: Set<DismissMethod>,
		animations: Animations
    ) {
		self.sourceView = sourceView
        self.layout = layout
        self.dismissMethods = dismissMethods
        self.animations = animations
    }
}

extension CxjToastConfiguration {
    //MARK: - Layout
    public struct Layout {
		public enum Placement {
			case top(verticalOffset: CGFloat)
			case center
			case bottom(verticalOffset: CGFloat)
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
        public struct Values {
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
        
        let width: Values
        let height: Values
        
        public init(
            width: Values,
            height: Values
        ) {
            self.width = width
            self.height = height
        }
    }
    
    //MARK: - DismissMethod
    public enum DismissMethod: Hashable, Equatable {
        public enum SwipeDirection: String, Hashable {
            case top, bottom, any
        }
        
        case tap
        case automatic(time: TimeInterval)
        case swipe(direction: SwipeDirection)
    }
    
    public struct Animations {
        public enum TopPlacementNativeView {
            case notch, dynamicIsland
        }
        
        public enum Changes: String, Hashable, CaseIterable {
            case alpha, scale, translation, shadowOverlay
        }
        
        let present: CxjAnimation
        let dismiss: CxjAnimation
        let changes: Set<Changes>
        let nativeViewsIncluding: Set<TopPlacementNativeView>
        
        public init(
            present: CxjAnimation,
            dismiss: CxjAnimation,
            changes: Set<Changes>,
            nativeViewsIncluding: Set<TopPlacementNativeView>
        ) {
            self.present = present
            self.dismiss = dismiss
            self.changes = changes
            self.nativeViewsIncluding = nativeViewsIncluding
        }
    }
}
