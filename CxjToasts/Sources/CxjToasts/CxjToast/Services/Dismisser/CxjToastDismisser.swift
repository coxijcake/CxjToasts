//
//  CxjToastDismisser.swift
//
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import UIKit

final class CxjToastDismisser {
	typealias DimissMethod = CxjToastConfiguration.HidingMethod
	typealias Toast = CxjToastable
	typealias ToastView = CxjToastView
	typealias Animator = CxjToastAnimator
	
	let toastView: ToastView
	let methods: Set<DimissMethod>
	let animator: CxjToastAnimator
	let onDismiss: VoidCompletion
	
	private lazy var dismissUseCases: [ToastDismissUseCase] = createDismissUseCases()
	
	init(
		toastView: ToastView,
		methods: Set<DimissMethod>,
		animator: CxjToastAnimator,
		onDismiss: @escaping VoidCompletion
	) {
		self.toastView = toastView
		self.methods = methods
		self.animator = animator
		self.onDismiss = onDismiss
	}
	
	deinit {
		print("OMG CxjToastDismisser deinit")
	}
	
	func activate() {
		dismissUseCases.forEach { $0.activate() }
	}
	
	private func createDismissUseCases() -> [ToastDismissUseCase] {
		methods.compactMap { method in
			useCase(for: method)
		}
	}
	
	private func useCase(for method: DimissMethod) -> ToastDismissUseCase? {
		let closeAction: VoidCompletion = closeActionWith(
			animator: animator,
			toastView: toastView
		)
		
		switch method {
		case .automatic(time: let time):
			return DimissByTimeUseCase(
				displayingTime: time,
				onFinish: closeAction
			)
		case .tap:
			return DimissByTouchUseCase(
				toastView: toastView,
				finishCompletion: closeAction
			)
		default:
			return nil
		}
	}
	
	private func closeActionWith(
		animator: Animator,
		toastView: ToastView
	) -> VoidCompletion {
		return {
			animator.hideAction(
				completion: { [weak self] _ in
					self?.onDismiss()
				}
			)
		}
	}
}


extension CxjToastDismisser {
	protocol ToastDismissUseCase {
		func activate()
		func pause()
	}
}



extension CxjToastDismisser {
	final class DimissByTimeUseCase: ToastDismissUseCase {
		private var dismissTimer: Timer?
		private var pausedTime: TimeInterval?
		
		private let finishCompletion: VoidCompletion?
		
		let displayingTime: TimeInterval
		
		init(
			displayingTime: TimeInterval,
			onFinish: VoidCompletion?
		) {
			self.displayingTime = displayingTime
			self.finishCompletion = onFinish
		}
		
		func activate() {
			start()
		}
		
		func start() {
			if let pausedTime {
				setupTimer(
					for: pausedTime,
					onFire: finishCompletion
				)
			} else {
				setupTimer(
					for: displayingTime,
					onFire: finishCompletion
				)
			}
		}
		
		func pause() {
			pausedTime = dismissTimer?.fireDate.timeIntervalSinceNow
			dismissTimer?.invalidate()
		}
		
		private func setupTimer(
			for time: TimeInterval,
			onFire: VoidCompletion?
		) {
			dismissTimer = Timer.scheduledTimer(
				withTimeInterval: time,
				repeats: false,
				block: { [weak self] _ in
					self?.finishCompletion?()
				}
			)
		}
	}
}


extension CxjToastDismisser {
	final class DimissByTouchUseCase: ToastDismissUseCase {
		private let toastView: CxjToastView
		private let finishCompletion: VoidCompletion?
		
		private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(handleToastTap)
		)
		
		init(
			toastView: CxjToastView,
			finishCompletion: VoidCompletion?
		) {
			self.toastView = toastView
			self.finishCompletion = finishCompletion
		}
		
		func activate() {
			removeGesture()
			addGesture()
		}
		
		func pause() {
			removeGesture()
		}
		
		private func addGesture() {
			toastView.addGestureRecognizer(tapGesture)
		}
		
		private func removeGesture() {
			toastView.removeGestureRecognizer(tapGesture)
		}
		
		@objc private func handleToastTap() {
			finishCompletion?()
		}
	}
}

