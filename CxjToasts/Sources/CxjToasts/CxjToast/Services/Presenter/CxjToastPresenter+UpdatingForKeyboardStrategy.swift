//
//  CxjToastPresenter+UpdatingForKeyboardStrategy.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import UIKit

extension CxjToastPresenter {
	@MainActor
	struct UpdatingForKeyboardStrategy {
		typealias ToastConfig = CxjToastConfiguration

		enum Action {
			struct KeyboardAnimationValues {
				let duration: TimeInterval
				let curveValue: UInt
			}
			
			struct SetupBottomPaddingActionParams {
				let padding: CGFloat
				let animationValues: KeyboardAnimationValues
			}
			
			case defaultPosition
			case setupBottomPadding(params: SetupBottomPaddingActionParams)
		}
		
		let toastConfig: ToastConfig
		let toastView: UIView
		
		func actionForState(_ keyboardState: CxjKeyboardDisplayingState) -> Action {
			guard shouldUpdateToastWithConfig(toastConfig) else { return .defaultPosition }
			
			switch keyboardState {
			case .hiden: return .defaultPosition
			case .displaying(data: let data):
				let sourceView: UIView = toastConfig.sourceView
				let convertedKeyboardEndResult: CGRect = sourceView.convert(data.rect, from: UIApplication.keyWindow)
				let keyboardOverlapValue: CGFloat = toastView.frame.maxY - convertedKeyboardEndResult.origin.y
				
				guard keyboardOverlapValue > .zero else { return .defaultPosition }
				
				let additionalPadding: CGFloat = 10
				let toastHeight: CGFloat = convertedKeyboardEndResult.size.height
				let bottomPadding: CGFloat = toastHeight + additionalPadding
				
				return .setupBottomPadding(
					params: .init(
						padding: bottomPadding,
						animationValues: .init(duration: data.animationDuration, curveValue: data.curveValue)
					)
				)
			}
		}
		
		private func shouldUpdateToastWithConfig(_ config: ToastConfig) -> Bool {
			guard
				config.sourceView.safeAreaInsets == UIApplication.keyWindow?.safeAreaInsets
			else { return false }
			
			return true
		}
	}
}
