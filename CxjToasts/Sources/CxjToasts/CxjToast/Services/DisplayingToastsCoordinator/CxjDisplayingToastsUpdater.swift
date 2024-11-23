//
//  CxjActiveToastsUpdater.swift
//  
//
//  Created by Nikita Begletskiy on 31/08/2024.
//

import UIKit

//MARK: - Types
extension CxjDisplayingToastsUpdater {
    typealias Toast = any CxjDisplayableToast
    typealias ToastView = CxjToastView
    typealias Placement = CxjToastConfiguration.Layout.Placement
    typealias Animation = CxjAnimation
	typealias Progress = ToastLayoutProgress
    
    enum Multipliers {
        static let yOffset: CGFloat = 5.0
        static let scale: CGFloat = 0.02
    }
}

//MARK: - Toasts layout updating
@MainActor
enum CxjDisplayingToastsUpdater {
	static func stackLayoutToasts(
		toastsToStack: [Toast],
		progress: CGFloat,
		maxVisibleToasts: Int
	) {
		toastsToStack
			.enumerated()
			.forEach { index, toast in
				let alpha: CGFloat = (index < maxVisibleToasts)
				? 1.0
				: 0.0
				
				updateStackLayout(
					toast: toast,
					progress: progress,
					atIndex: index,
					alpha: alpha
				)
			}
	}
	
	static func updateAlphaForToasts(
		_ toastsToHide: [Toast],
		progress: CGFloat
	) {
		toastsToHide
			.enumerated()
			.forEach {
				setAlphaWithProgresss(
					progress,
					toToast: $0.element,
					atIndex: $0.offset
				)
			}
	}
}

//MARK: - Single toast layout updating
private extension CxjDisplayingToastsUpdater {
	static func updateStackLayout(
		toast: Toast,
		progress: CGFloat,
		atIndex index: Int,
		alpha: CGFloat
	) {
		guard
			shouldUpdateToastWith(displayingState: toast.displayingState)
		else { return }
		
		let placement = toast.config.layout.placement
		let progress = ToastLayoutProgress(value: progress)
		
		let finalYOffset: CGFloat = yOffset(
			for: index,
			multiplier: Multipliers.yOffset,
			onPlacement: placement
		)
		
		let finalXScale: CGFloat = xScale(
			for: index,
			multiplier: Multipliers.scale,
			onPlacement: placement
		)
		
		let minXScale: CGFloat = finalXScale + Multipliers.scale
		
		let toastView: ToastView = toast.view
		
		let xScale: CGFloat = minXScale + (finalXScale - minXScale) * progress.value
		
		toastView.alpha = alpha
		toastView.transform = CGAffineTransform(scaleX: xScale, y: 1.0)
			.concatenating(CGAffineTransform(translationX: .zero, y: finalYOffset))
	}
	
	static func setAlphaWithProgresss(
		_ progress: CGFloat,
		toToast toast: Toast,
		atIndex index: Int
	) {
		let isTopToast: Bool = index == 0
		let progress: ToastLayoutProgress = .init(value: progress)
		let alphaValue: CGFloat = isTopToast
		? progress.value
		: progress.revertedValue
		
		toast.view.alpha = alphaValue
		toast.sourceBackgroundView?.alpha = alphaValue
	}
}

//MARK: - Calculations
private extension CxjDisplayingToastsUpdater {
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
	
	static func shouldUpdateToastWith(
		displayingState: CxjToastDisplayingState
	) -> Bool {
		switch displayingState {
		case .presented, .presenting: true
		default: false
		}
	}
}
