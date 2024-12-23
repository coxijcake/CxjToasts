//
//  CxjToastAnimator+SourceBackgroundLayoutCalculator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 23/12/2024.
//

import UIKit

extension CxjToastAnimator {
    struct SourceBackgroundLayoutCalculator {
        //MARK: - Types
        typealias Properties = SourceBackgroundAnimatingProperties
        typealias Progress = ToastLayoutProgress
        
        //MARK: - Props
        let presentedStateProps: Properties
        let dismissedStateProps: Properties
        
        func propertiesFor(progress: Progress) -> Properties {
            let alpha: CGFloat = alphaValueFor(progress: progress)
            
            return Properties(
                alpha: .init(value: alpha)
            )
        }
        
        //MARK: - Alpha
        private func alphaValueFor(progress: Progress) -> CGFloat {
            let initialAlpha: CGFloat = presentedStateProps.alpha.value
            
            let finalAlpha: CGFloat = dismissedStateProps.alpha.value
            let alpha: CGFloat =
            finalAlpha
            * progress.value
            + initialAlpha
            * progress.revertedValue
            
            return alpha
        }
    }
}
