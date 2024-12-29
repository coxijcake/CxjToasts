//
//  CxjToastDismisser+BySwipeUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import UIKit

extension CxjToastDismisser {
	@MainActor
	final class DismissBySwipeUseCase {
		//MARK: - Types
		enum Constants {
			static let dismissThresholdProgress: CGFloat = 0.075
		}
		
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
        
        private lazy var dismissedStateTranslation: CGPoint = {
            let animatorTranslation: CGPoint = animator.dismissedStateTranslation
            let x: CGFloat = max(abs(animatorTranslation.x), toastView.bounds.size.width)
            let y: CGFloat = max(abs(animatorTranslation.y), toastView.bounds.size.height)
            
            return CGPoint(x: x, y: y)
        }()
        
        private var startViewOrigin: CGFloat = 0
        private var startGestureLocation: CGFloat = 0
        private var currentOriginOffset: CGFloat = .zero
		
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
	}
}

//MARK: - ToastDismissUseCase
extension CxjToastDismisser.DismissBySwipeUseCase: ToastDismissUseCase {
	var dismissMethod: ToastDimissMethod {
		.swipe
	}
	
	func setupState(_ state: ToastDismisserState) {
		switch state {
		case .active: activate()
		case .inActive: deactivate()
		case .paused: pause()
		}
	}
}

//MARK: - Setup
private extension CxjToastDismisser.DismissBySwipeUseCase {
    func activate() {
        addGesture()
    }
    
    func pause() {
        
    }
    
    func deactivate() {
        removeGesture()
    }
    
    func addGesture() {
        removeGesture()
        toastView.addGestureRecognizer(swipeGesture)
    }
    
    func removeGesture() {
        toastView.removeGestureRecognizer(swipeGesture)
    }
}

//MARK: - Swipe handling
private extension CxjToastDismisser.DismissBySwipeUseCase {
    @objc
    func handleToastSwipe(_ gesture: UIPanGestureRecognizer) {
        guard
            let toastSuperView: UIView = toastView.superview
        else { return }
        
        switch gesture.state {
        case .began:
            setupSwipeBeganPropsForGesture(gesture, insideView: toastSuperView)
            delegate?.didStartInteractive(by: self)
        case .changed:
            handleSwipeChangedWithGesture(
                gesture,
                insideView: toastSuperView
            )
        case .ended:
			let shouldDismissToast = shouldDismissToastForEndedGesture(gesture, insideView: toastSuperView)
            
            if shouldDismissToast {
                delegate?.didFinish(useCase: self)
            } else {
                animator.dismissAction(progress: .zero, animated: true) { [weak self] _ in
                    self?.updateDislplayingToasts(animated: true, progress: ToastLayoutProgress.max.value)
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
    
    func setupSwipeBeganPropsForGesture(
        _ gesture: UIPanGestureRecognizer,
        insideView toastSuperView: UIView
    ) {
        switch direction {
        case .top, .bottom:
            setupVertycalySwipeBeganPropsForGesture(
                gesture,
                insideView: toastSuperView
            )
        case .left, .right:
            setupHorizontalySwipeBeganPropsForGesture(
                gesture,
                insideView: toastSuperView
            )
        }
    }
    
    func setupHorizontalySwipeBeganPropsForGesture(
        _ gesture: UIPanGestureRecognizer,
        insideView toastSuperView: UIView
    ) {
        startViewOrigin = toastView.frame.origin.x
        startGestureLocation = gesture.location(in: toastSuperView).x
    }
    
    func setupVertycalySwipeBeganPropsForGesture(
        _ gesture: UIPanGestureRecognizer,
        insideView toastSuperView: UIView
    ) {
        startViewOrigin = toastView.frame.origin.y
        startGestureLocation = gesture.location(in: toastSuperView).y
    }
    
    func handleSwipeChangedWithGesture(
        _ gesture: UIPanGestureRecognizer,
        insideView toastSuperView: UIView
    ) {
		let delta: CGFloat = deltaForSwipeGesture(gesture, insideView: toastSuperView)
		
		guard
			shouldApply(delta: delta, for: direction, with: placement)
		else {
			animator.dismissAction(progress: .zero, animated: true, completion: nil)
			return
		}
        
        updateDuringInteractionGesture(
            gesture,
            insideView: toastSuperView,
            withDelta: delta
        )
    }
}

//MARK: - Toast updates
private extension CxjToastDismisser.DismissBySwipeUseCase {
    func updateDuringInteractionGesture(
        _ gesture: UIPanGestureRecognizer,
        insideView toastSuperView: UIView,
        withDelta delta: CGFloat
    ) {
        currentOriginOffset = startViewOrigin + delta
        let progressValue: CGFloat = draggedProgress()
        let progress: ToastLayoutProgress = ToastLayoutProgress(value: progressValue)
        
        updateDislplayingToasts(animated: false, progress: progress.revertedValue)
        animator.dismissAction(progress: progress.value, animated: false, completion: nil)
    }
    
    func resume() {
        delegate?.didEndInteractive(by: self)
    }
    
    func updateDislplayingToasts(animated: Bool, progress: CGFloat) {
        let toastCoordinator: CxjToastsCoordinator = CxjToastsCoordinator.shared
        guard let targetToast: any CxjDisplayableToast = toastCoordinator.first(withId: toastId) else { return }
        
        CxjDisplayingToastsCoordinator.updateLayoutFor(
            displayingToasts: toastCoordinator.activeToasts,
            linkedToToast: targetToast,
            withProgress: progress,
            animation: animated ? animator.dismissAnimation : .noAnimation,
            completion: nil
        )
    }
}

//MARK: - Calculations
private extension CxjToastDismisser.DismissBySwipeUseCase {
    func ammountOfUserDragged() -> CGFloat {
        abs(startViewOrigin - currentOriginOffset)
    }
    
    func draggedProgress() -> CGFloat {
        let destination: CGFloat = switch direction {
        case .top, .bottom: dismissedStateTranslation.y
        case .left, .right: dismissedStateTranslation.x
        }
        
        let ammountOfDragged: CGFloat = ammountOfUserDragged()
        let progress: CGFloat = ammountOfDragged / abs(destination)
        
        return progress
    }
	
	func deltaForSwipeGesture(_ gesture: UIPanGestureRecognizer, insideView toastSuperView: UIView) -> CGFloat {
		switch direction {
		case .top, .bottom:
			gesture.location(in: toastSuperView).y - startGestureLocation
		case .left, .right:
			gesture.location(in: toastSuperView).x - startGestureLocation
		}
	}
    
    func shouldApply(
        delta: CGFloat,
        for direction: SwipeDirection,
        with placement: ToastPlacement
    ) -> Bool {
        switch direction {
        case .top, .left: delta <= 0
        case .bottom, .right: delta >= 0
        }
    }
	
	func shouldDismissToastForEndedGesture(_ gesture: UIPanGestureRecognizer, insideView toastSuperView: UIView) -> Bool {
		let delta: CGFloat = deltaForSwipeGesture(gesture, insideView: toastSuperView)
		
		guard shouldApply(delta: delta, for: direction, with: placement) else { return false }
		
		let progressValue: CGFloat = draggedProgress()
		
		return progressValue >= Constants.dismissThresholdProgress
	}
}
