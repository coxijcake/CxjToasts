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

//MARK: - Public toasts updating
enum CxjActiveToastsUpdater {
    static func updateLayout(
        activeToasts: [Toast],
		progress: CGFloat,
        on placement: Placement,
        animation: Animation,
        completion: BoolCompletion?
    ) {
		let orderedToasts: [Toast] = orderedToasts(
			on: placement,
			from: activeToasts
		)
		
        let actions: VoidCompletion = {
			orderedToasts
				.enumerated()
				.forEach { index, toast in
					update(
						toast: toast,
						progress: progress,
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
	
	static func updateDisplayingState(
		activeToasts: [Toast],
		on placement: Placement
	) {
		let orderedToasts = orderedToasts(
			on: placement,
			from: activeToasts
		)
		
		orderedToasts
			.enumerated()
			.forEach { index, toast in
				updateDismissMethodsFor(toast: toast, at: index)
			}
	}
}

//MARK: - Single toast layout updating
private extension CxjActiveToastsUpdater {
	static func update(
		toast: Toast,
		progress: CGFloat,
		atIndex index: Int,
		onPlacement placement: Placement
	) {
		guard
			shouldUpdateToastWith(displayingState: toast.displayingState)
		else { return}
		
		let progress = ToastLayoutProgress(value: progress)
		
		let finalYOffset: CGFloat = yOffset(
			for: index,
			multiplier: Multipliers.yOffset,
			onPlacement: placement
		)
		let minYOffset: CGFloat = max(.zero, finalYOffset - Multipliers.yOffset)
		
		let finalXScale: CGFloat = xScale(
			for: index,
			multiplier: Multipliers.scale,
			onPlacement: placement
		)
		let minXScale: CGFloat = finalXScale + Multipliers.scale
		
		let maxVisibleToasts: Int = maxVisibleToasts(for: placement)
		let alpha: CGFloat = (index < maxVisibleToasts) ? 1.0 : 0.0
		
		let toastView: ToastView = toast.view
		
		let yOffset: CGFloat = minYOffset + (finalYOffset - minYOffset) * progress.value
		let xScale: CGFloat = minXScale + (finalXScale - minXScale) * progress.value
		
		toastView.alpha = alpha
		toastView.transform = CGAffineTransform(scaleX: xScale, y: 1.0)
			.concatenating(CGAffineTransform(translationX: .zero, y: finalYOffset))
	}
}

//MARK: - Dismiss methods updates
private extension CxjActiveToastsUpdater {
	static func updateDismissMethodsFor(
		toast: Toast,
		at index: Int
	) {
		let shouldPauseDismissing: Bool = index != 0
		
		shouldPauseDismissing
		? toast.dismisser.pause()
		: toast.dismisser.activate()
	}
}

//MARK: - Toasts ordering
private extension CxjActiveToastsUpdater {
	static func orderedToasts(
		on placement: Placement,
		from activeToasts: [Toast]
	) -> [Toast] {
		activeToasts
			.filter {
				ToastPlacementComparator(
					lhs: $0.config.layout.placement,
					rhs: placement
				).isFullyEqauls()
			}
			.reversed()
	}
}

//MARK: - Calculations
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
    
    static func xScale(
        for index: Int,
        multiplier: CGFloat,
        onPlacement placement: Placement
    ) -> CGFloat {
        switch placement {
        case .top, .bottom, .center:
            let scale: CGFloat = 1.0 - (multiplier * CGFloat(index))
            return scale
        }
    }
    
    static func maxVisibleToasts(for placement: Placement) -> Int {
        switch placement {
        case .top, .bottom: 5
        case .center: 3
        }
    }
	
	static func shouldUpdateToastWith(
		displayingState: Toast.DisplayingState
	) -> Bool {
		switch displayingState {
		case .presented, .presenting: true
		default: false
		}
	}
}
