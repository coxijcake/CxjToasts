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
		typealias Animator = CxjToastDismissAnimator
		typealias SwipeDirection = CxjToastConfiguration.DismissMethod.SwipeDirection
		typealias ToastPlacement = CxjToastConfiguration.Layout.Placement
		
		//MARK: - Props
		private let toastId: UUID
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
		
		private let thresholdToDismiss = 15.0
		
		private var startViewY: CGFloat = 0
		private var startGestureY: CGFloat = 0
		private var currentY: CGFloat = .zero
		
		//MARK: - Lifecycle
		init(
			toastId: UUID,
			toastView: ToastView,
			direction: SwipeDirection,
			placement: ToastPlacement,
			animator: Animator,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.toastId = toastId
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
				startViewY = toastView.frame.origin.y
				startGestureY = gesture.location(in: toastSuperView).y
				delegate?.didStartInteractive(by: self)
			case .changed:
				let delta = gesture.location(in: toastSuperView).y - startGestureY
				
				guard
					shouldApply(delta: delta, for: direction, with: placement)
				else {
					animator.dismissAction(progress: .zero, animated: true, completion: nil)
					break
				}
				
				let ammountOfUserDragged = ammountOfUserDragged()
				let progress = ammountOfUserDragged / startViewY
				
				updateDislplayingToasts(animated: false, progress: 1.0 - progress)
				
				currentY = startViewY + delta
				
				animator.dismissAction(progress: progress, animated: false, completion: nil)
			case .ended:
				let ammountOfUserDragged = ammountOfUserDragged()
				let shouldDismissToast = ammountOfUserDragged > thresholdToDismiss
				
				if shouldDismissToast {
					delegate?.didFinish(useCase: self)
				} else {
					animator.dismissAction(progress: .zero, animated: true) { [weak self] _ in
						self?.updateDislplayingToasts(animated: true, progress: 1.0)
						self?.resume()
					}
				}
			case .failed, .cancelled:
				animator.dismissAction(progress: .zero, animated: true, completion: nil)
				resume()
			default:
				animator.dismissAction(progress: .zero, animated: true, completion: nil)
			}
		}
		
		private func ammountOfUserDragged() -> CGFloat {
			abs(startViewY - currentY)
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
		
		private func updateDislplayingToasts(animated: Bool, progress: CGFloat) {
			CxjActiveToastsUpdater.updateLayout(
				activeToasts: CxjToast.activeToasts,
				progress: progress,
				on: placement,
				animation: animated ? animator.dismissAnimation : .noAnimation,
				completion: nil
			)
		}
	}
}