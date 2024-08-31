//
//  CxjActiveToastsUpdater.swift
//  
//
//  Created by Nikita Begletskiy on 31/08/2024.
//

import UIKit

//MARK: - Types
extension CxjActiveToastsUpdater {
    typealias Toast = CxjToast
    typealias ToastView = CxjToastView
    typealias Placement = CxjToastConfiguration.Layout.Placement
    typealias Animation = CxjAnimation
    
    enum Multipliers {
        static let yOffset: CGFloat = 10.0
        static let scale: CGFloat = 0.05
    }
}

//MARK: - Public update
enum CxjActiveToastsUpdater {
    static func update(
        activeToasts: [Toast],
        on placement: Placement,
        animation: Animation,
        completion: BoolCompletion?
    ) {
        let actions: VoidCompletion = {
            activeToasts
                .filter {
                    ToastPlacementComparator(
                        lhs: $0.config.layout.placement,
                        rhs: placement
                    ).isFullyEqauls()
                }
                .reversed()
                .enumerated()
                .forEach { index, toast in
                    update(
                        toastView: toast.view,
                        atIndex: index,
                        onPlacement: placement
                    )
                }
        }
        
        UIView.animate(
            with: animation,
            animations: actions,
            completion: completion
        )
    }
    
    private static func update(
        toastView: ToastView,
        atIndex index: Int,
        onPlacement placement: Placement
    ) {
        let yOffset: CGFloat = yOffset(
            for: index,
            multiplier: Multipliers.yOffset,
            onPlacement: placement
        )
        
        let scale: CGPoint = scale(
            for: index,
            multiplier: Multipliers.scale,
            onPlacement: placement
        )
        
        let maxVisibleToasts: Int = maxVisibleToasts(for: placement)
        let alpha: CGFloat = (index < maxVisibleToasts) ? 1.0 : 0.0
        
        toastView.alpha = alpha
        toastView.transform = CGAffineTransform(scaleX: scale.x, y: scale.y)
            .concatenating(CGAffineTransform(translationX: .zero, y: yOffset))
    }
}

//MARK: - Private calculations
private extension CxjActiveToastsUpdater {
    static func yOffset(
        for index: Int,
        multiplier: CGFloat,
        onPlacement placement: Placement
    ) -> CGFloat {
        switch placement {
        case .top, .center: multiplier * CGFloat(index)
        case .bottom: -multiplier * CGFloat(index)
        }
    }
    
    static func scale(
        for index: Int,
        multiplier: CGFloat,
        onPlacement placement: Placement
    ) -> CGPoint {
        switch placement {
        case .top, .bottom, .center:
            let scale: CGFloat = 1.0 - (multiplier * CGFloat(index))
            return CGPoint(x: scale, y: 1.0)
        }
    }
    
    static func maxVisibleToasts(for placement: Placement) -> Int {
        switch placement {
        case .top, .bottom: 5
        case .center: 3
        }
    }
}
