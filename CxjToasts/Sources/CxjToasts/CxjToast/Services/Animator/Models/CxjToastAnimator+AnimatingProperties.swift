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
        
        let alpha: ClampedAlpha
        let scale: Scale
		let translation: Translation
        let cornerRadius: CGFloat
        let shadowIntensity: ClampedAlpha
    }
}

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
