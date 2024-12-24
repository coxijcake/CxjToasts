//
//  CxjToastAnimator+AnimatingProperties.swift
//
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
    struct ToastAnimatingProperties {
        struct Scale {
            let x: CGFloat
            let y: CGFloat
            
			static var initial: Scale { Scale(x: 1.0, y: 1.0) }
        }
		
		struct Translation {
			let x: CGFloat
			let y: CGFloat
			
			static var initial: Translation { Translation(x: .zero, y: .zero) }
            
            var cgPoint: CGPoint { CGPoint(x: x, y: y) }
		}
		
		struct CornerRadius {
			enum Constraint {
				case none
				case halfHeight
			}
			
			let value: CGFloat
			let constraint: Constraint
		}
		
		enum ShadowOverlay: Equatable {
			case off
			case on(color: UIColor, alpha: ClampedAlpha)
			
			static func == (lhs: ShadowOverlay, rhs: ShadowOverlay) -> Bool {
				switch (lhs, rhs) {
				case (.off, .off): 
					return true
				case (.on(let lhsColor, let lhsShadow), .on(let rhsColor, let rhsShadow)):
					return (lhsColor == rhsColor) && (lhsShadow.value == rhsShadow.value)
				default:
					return false
				}
			}
		}
        
        let alpha: ClampedAlpha
        let scale: Scale
		let translation: Translation
		let cornerRadius: CornerRadius
		let shadowOverlay: ShadowOverlay
    }
	
	struct SourceBackgroundAnimatingProperties {
		let alpha: ClampedAlpha
	}
}
