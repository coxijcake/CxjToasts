//
//  CxjToastDismisser+BySwipeUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import UIKit

extension CxjToastDismisser {
	final class DismissBySwipeUseCase: ToastDismissUseCase {
		//MARK: - Types
		typealias ToastView = CxjToastView
		typealias Animator = CxjToastAnimator
		typealias SwipeDirection = CxjToastConfiguration.DismissMethod.SwipeDirection
		typealias ToastPlacement = CxjToastConfiguration.Layout.Placement
		
		//MARK: - Props
		private let toastView: ToastView
		private let direction: SwipeDirection
		private let placement: ToastPlacement
		private let animator: Animator
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private lazy var swipeGesture: UIPanGestureRecognizer = {
			let gesture: UIPanGestureRecognizer = UIPanGestureRecognizer(
				target: self,
				action: #selector(handleToastSwipe)
			)
			
			return gesture
		}()
		
		private let thresholdToDismiss = 25.0
		
		private var startY: CGFloat = 0
		private var startShiftY: CGFloat = 0
		
		//MARK: - Lifecycle
		init(
			toastView: ToastView,
			direction: SwipeDirection,
			placement: ToastPlacement,
			animator: Animator,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.toastView = toastView
			self.direction = direction
			self.placement = placement
			self.animator = animator
			self.delegate = delegate
		}
		
		//MARK: - Public
		func activate() {
			addGesture()
		}
		
		func pause() {
			
		}
		
		func deactivate() {
			removeGesture()
		}
		
		//MARK: - Private
		private func addGesture() {
			removeGesture()
			toastView.addGestureRecognizer(swipeGesture)
		}
		
		private func removeGesture() {
			toastView.removeGestureRecognizer(swipeGesture)
		}
		
		@objc private func handleToastSwipe(_ gesture: UIPanGestureRecognizer) {
			guard
				let toastSuperView: UIView = toastView.superview
			else { return }
			
			switch gesture.state {
			case .began:
				startY = toastView.frame.origin.y
				startShiftY = gesture.location(in: toastSuperView).y
				delegate?.didStartInteractive(by: self)
			case .changed:
				let delta = gesture.location(in: toastSuperView).y - startShiftY
				
				guard
					shouldApply(delta: delta, for: direction, with: placement)
				else { break }
				
				toastView.frame.origin.y = startY + delta
			case .ended:
				let ammountOfUserDragged = abs(startY - toastView.frame.origin.y)
				let shouldDismissToast = ammountOfUserDragged > thresholdToDismiss
				
				if shouldDismissToast {
					delegate?.didFinish(useCase: self)
				} else {
					UIView.animate(
						with: animator.config.animations.present.animator,
						animations: { self.toastView.frame.origin.y = self.startY },
						completion: { [weak self] _ in
							self?.resume()
						}
					)
				}
			case .failed, .cancelled:
				resume()
			default:
				break
			}
		}
		
		private func resume() {
			delegate?.didEndInteractive(by: self)
		}
		
		private func shouldApply(
			delta: CGFloat,
			for direction: SwipeDirection,
			with placement: ToastPlacement
		) -> Bool {
			switch direction {
			case .top:
				delta <= 0
			case .bottom:
				delta >= 0
			case .any:
				switch placement {
				case .top:
					delta <= 0
				case .bottom:
					delta >= 0
				case .center:
					delta <= 0
				}
			}
		}
	}
}
