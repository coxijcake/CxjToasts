//
//  CxjToastAnimator+TopNotchLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopNotchLayoutUseCase: BaseLayoutUseCase, TopLayoutUseCase {
		let verticalOffset: CGFloat
        
        override var dismissedStateAnimatingProps: AnimatingProperties {
            AnimatingProperties(
                alpha: 1.0,
                scale: getDismissedScale(),
                translationY: getDismissedYTranslation(),
                cornerRadius: CxjNotchHelper.estimatedBottomCornerRadius,
                shadowIntensity: 1.0
            )
        }
		
		init(
			toastView: ToastView,
            config: ToastConfig,
			verticalOffset: CGFloat
		) {
			self.verticalOffset = verticalOffset
            super.init(
                toastView: toastView,
                config: config
            )
		}
		
		func beforeDisplayingLayout(progress: ToastLayoutProgress) {
            addTransitionDimmedView(dimColor: CxjNotchHelper.backgroundColor)
			dismissLayout(progress: progress)
		}
		
		func presentingLayout() {
            setDefaultToastViewValues()
		}
        
        private func getDismissedScale() -> AnimatingProperties.Scale {
            let sourceView: UIView = config.sourceView
            let toastSize: CGSize = toastView.bounds.size
            let notchSize: CGSize = CxjNotchHelper.notchSize
            
            let xScale: CGFloat =
            min(notchSize.width, toastSize.width)
            / max(notchSize.width, toastSize.width)
            
            let yScale: CGFloat =
            min(notchSize.height, toastSize.height)
            / max(notchSize.height, toastSize.height)
            
            return .init(x: xScale, y: yScale)
        }
        
        private func getDismissedYTranslation() -> CGFloat {
            let topSafeArea: CGFloat = config.sourceView.safeAreaInsets.top
            
            let yTranslation: CGFloat =
            verticalOffset
            + topSafeArea
            - (topSafeArea - CxjDynamicIslandHelper.estimatedMinHeight)
            
            return -yTranslation
        }
	}
}
