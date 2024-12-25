//
//  CxjToastAnimator+CustomConfigPropertiesBuilder.swift
//
//
//  Created by Nikita Begletskiy on 02/10/2024.
//

import Foundation
import UIKit.UIScreen

extension CxjToastAnimator {
	@MainActor
	final class CustomConfigPropertiesBuilder {
		//MARK: - Types
		typealias Animations = CxjToastConfiguration.Animation
		typealias Input = ConfigStrategyCommonInput
		typealias Change = ToastConfig.Animation.Behaviour.CustomBehaviourChange
		
		//MARK: - Props
		let input: Input
		
		private(set) var alpha: ClampedAlpha
		private(set) var scale: ToastAnimatingProperties.Scale
		private(set) var translation: ToastAnimatingProperties.Translation
		private(set) var cornerRadius: ToastAnimatingProperties.CornerRadius
		private(set) var shadowOverlay: ToastAnimatingProperties.ShadowOverlay
		
		//MARK: - Lifecycle
		init(input: Input) {
			self.input = input
			self.alpha = input.presentedStateAnimatingProperties.alpha
			self.scale = input.presentedStateAnimatingProperties.scale
			self.translation = input.presentedStateAnimatingProperties.translation
			self.cornerRadius = input.presentedStateAnimatingProperties.cornerRadius
			self.shadowOverlay = input.presentedStateAnimatingProperties.shadowOverlay
		}
		
		//MARK: - Updating
		@discardableResult
		func update(with change: Change) -> CustomConfigPropertiesBuilder {
			switch change {
			case .scale(let value):
				scale = ToastAnimatingProperties.Scale(x: value.x, y: value.y)
			case .translation(let type):
				translation = translationFor(translationType: type)
			case .alpha(let intensity):
				alpha = ClampedAlpha(value: intensity)
			case .shadowOverlay(let color, let intensity):
				shadowOverlay = .on(color: color, alpha: ClampedAlpha(value: intensity))
			case .corners(let radius):
				cornerRadius = cornerRadiusValue(for: radius)
			}
			
			return self
		}
		
		//MARK: - Building
		func build() -> ToastAnimatingProperties {
			return ToastAnimatingProperties(
				alpha: alpha,
				scale: scale,
				translation: translation,
				cornerRadius: cornerRadius,
				shadowOverlay: shadowOverlay
			)
		}
		
		//MARK: - Translation
		private func translationFor(
			translationType: Change.TranslationType
		) -> ToastAnimatingProperties.Translation {
			switch translationType {
			case .outOfSourceViewVerticaly: 
				return outOfSourceViewVerticalTranslation()
			case .outOfSourceViewHorizontaly(direction: let direction):
				return outOfSourceViewHorizontalyTranslationForDirection(direction)
			case .custom(value: let value):
				return ToastAnimatingProperties.Translation(x: value.x, y: value.y)
			}
		}
		
		private func outOfSourceViewVerticalTranslation() -> ToastAnimatingProperties.Translation {
			let tranlationX: CGFloat = .zero
			
			switch input.toastViewData.placement {
			case .top(let params):
				let safeAreaInset: CGFloat = params.includingSafeArea
				? input.sourceViewData.safeAreaInsets.top
				: .zero
				
				let translationY: CGFloat =
				params.offset
				+ safeAreaInset
				+ input.toastViewData.size.height
				
				return ToastAnimatingProperties.Translation(
					x: tranlationX,
					y: -translationY
				)
			case .center:
				return .zero
			case .bottom(let params):
				let safeAreaInset: CGFloat = params.includingSafeArea
				? input.sourceViewData.safeAreaInsets.bottom
				: .zero
				
				let translationY: CGFloat =
				params.offset
				+ safeAreaInset
				+ input.toastViewData.size.height
				
				return ToastAnimatingProperties.Translation(
					x: tranlationX,
					y: translationY
				)
			}
		}
		
		private func outOfSourceViewHorizontalyTranslationForDirection(
			_ direction: Change.TranslationType.HorizontalDirection
		) -> ToastAnimatingProperties.Translation {
			let sourceViewWidth: CGFloat = input.sourceViewData.frame.size.width
			let toastWidth: CGFloat = input.toastViewData.size.width
			let sideOffset: CGFloat = (sourceViewWidth - toastWidth) / 2
			let translationY: CGFloat = .zero
			
			switch direction {
			case .left:
				let safeAreaInset: CGFloat = input.sourceViewData.safeAreaInsets.left
				let translationX: CGFloat = -(sideOffset + toastWidth + safeAreaInset)
				
				return .init(x: translationX, y: translationY)
			case .right:
				let safeAreaInset: CGFloat = input.sourceViewData.safeAreaInsets.right
				let translationX: CGFloat = sideOffset + toastWidth + safeAreaInset
				
				return .init(x: translationX, y: translationY)
			}
		}
		
		//MARK: - CornerRadius
		private func cornerRadiusValue(
			for cornerRadius: Animations.Behaviour.CustomBehaviourChange.CornerRadius
		) -> ToastAnimatingProperties.CornerRadius {
			let constraint: ToastAnimatingProperties.CornerRadius.Constraint = {
				switch cornerRadius.constraint {
				case .halfHeigt: .halfHeight
				case .none: .none
				}
			}()
			
			let value: CGFloat = {
				switch cornerRadius.type {
				case .screenCornerRadius: UIScreen.main.displayCornerRadius
				case .custom(value: let value): value
				}
			}()
			
			return ToastAnimatingProperties.CornerRadius(
				value: value,
				constraint: constraint
			)
		}
	}
}
