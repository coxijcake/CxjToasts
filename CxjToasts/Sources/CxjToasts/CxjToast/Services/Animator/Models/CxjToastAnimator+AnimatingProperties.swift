//
//  CxjToastAnimator+AnimatingProperties.swift
//
//
//  Created by Nikita Begletskiy on 14/09/2024.
//

import UIKit

extension CxjToastAnimator {
    struct AnimatingProperties {
        struct Scale {
            let x: CGFloat
            let y: CGFloat
            
            static var initial: Scale = Scale(x: 1.0, y: 1.0)
        }
		
		struct Translation {
			let x: CGFloat
			let y: CGFloat
			
			static var initial: Translation = Translation(x: .zero, y: .zero)
		}
		
		struct CornerRadius {
			enum Constraint {
				case none
				case halfHeight
			}
			
			let value: CGFloat
			let constraint: Constraint
		}
        
        let alpha: ClampedAlpha
        let scale: Scale
		let translation: Translation
		let cornerRadius: CornerRadius
        let shadowIntensity: ClampedAlpha
    }
}


//MARK: - AnimatingProperties + Changeable
extension CxjToastAnimator.AnimatingProperties: Changeable {
	init(copy: ChangeableWrapper<Self>) {
		self.init(
			alpha: copy.alpha,
			scale: copy.scale,
			translation: copy.translation,
			cornerRadius: copy.cornerRadius,
			shadowIntensity: copy.shadowIntensity
		)
	}
}

//MARK: - AnimatingProperties.CornerRadius + Changeable
extension CxjToastAnimator.AnimatingProperties.CornerRadius: Changeable {
	init(copy: ChangeableWrapper<Self>) {
		self.init(
			value: copy.value,
			constraint: copy.constraint
		)
	}
}
