//
//  CxjToastAnimator+TopDynamicIslandLayoutUC.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

extension CxjToastAnimator {
	final class TopDynamicIslandLayoutUseCase: BaseLayoutUseCase, TopLayoutUseCase {
		let verticalOffset: CGFloat
        
        override var dismissedStateDefaultAnimatingProps: AnimatingProperties {
            AnimatingProperties(
                alpha: 1.0,
                scale: dissmisScale(),
                translationY: dismissYTranslation(),
                cornerRadius: CxjDynamicIslandHelper.cornerRadius,
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
		
		func presentingLayout() {
			setDefaultToastViewValues()
		}
		
        private func dissmisScale() -> AnimatingProperties.Scale {
            let toastSize: CGSize = toastView.bounds.size
            let dynamicIslandAdjustedSize: CGSize = CGSize(
                width: CxjDynamicIslandHelper.minWidth - 6,
                height: CxjDynamicIslandHelper.estimatedMinHeight - 4
            )
            
            let xScale: CGFloat =
            min(dynamicIslandAdjustedSize.width, toastSize.width)
            / max(dynamicIslandAdjustedSize.width, toastSize.width)
            
            let yScale: CGFloat =
            min(dynamicIslandAdjustedSize.height, toastSize.height)
            / max(dynamicIslandAdjustedSize.height, toastSize.height)
            
            return .init(x: xScale, y: yScale)
        }
        
        private func dismissYTranslation() -> CGFloat {
            let yTranslation: CGFloat =
            verticalOffset
            + CxjDynamicIslandHelper.estimatedMinHeight
            + CxjDynamicIslandHelper.estimatedBottomOffset
            
            return -yTranslation
        }
	}
}
