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
        
        let alpha: CGFloat
        let scale: Scale
        let translationY: CGFloat
        let cornerRadius: CGFloat
        let shadowIntensity: CGFloat
    }
}
