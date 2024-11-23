//
//  CxjToastDismisser.swift
//
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import UIKit

//MARK: - Delegate
protocol CxjToastDismisserDelegate: AnyObject {
	func willDismissToastWith(id: UUID, by dismisser: CxjToastDismissable)
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismissable)
	func didUpdateRemainingDisplayingTime(
		_ time: TimeInterval,
		initialDisplayingTime: TimeInterval,
		forToastWithId toastId: UUID,
		by dismisser: CxjToastDismissable
	)
}

//MARK: - Interface
protocol CxjToastDismissable {
	var animator: CxjToastDismissAnimator { get }
	
	func activateDismissMethods()
	func deactivateDismissMethods()
	func pauseDismissMethods()
	func dismiss(animated: Bool)
}

//MARK: - Types
extension CxjToastDismisser {
	typealias DimissMethod = CxjToastConfiguration.DismissMethod
	typealias Configuration = CxjToastConfiguration
	typealias Toast = CxjToast
	typealias ToastView = CxjToastView
	typealias Animator = CxjToastDismissAnimator
}

//MARK: - Impl
@MainActor
final class CxjToastDismisser: CxjToastDismissable {
	//MARK: - Props
	private let toastId: UUID
	private let toastView: ToastView
	private let sourceBackgroundView: CxjToastSourceBackground?
	private let config: Configuration
	
	private lazy var dismissUseCases: [ToastDismissUseCase] = createDismissUseCases()
	
	let animator: Animator
	
	weak var delegate: CxjToastDismisserDelegate?
	
	//MARK: - Lifecycle
	init(
		toastId: UUID,
		toastView: ToastView,
		sourceBackgroundView: CxjToastSourceBackground?,
		config: Configuration,
		animator: CxjToastAnimator,
		delegate: CxjToastDismisserDelegate?
	) {
		self.toastId = toastId
		self.toastView = toastView
		self.sourceBackgroundView = sourceBackgroundView
		self.config = config
		self.animator = animator
		self.delegate = delegate
	}
}

//MARK: - Public
extension CxjToastDismisser {
	func activateDismissMethods() {
		dismissUseCases.forEach { $0.activate() }
	}
	
	func deactivateDismissMethods() {
		dismissUseCases.forEach { $0.deactivate() }
	}
	
	func pauseDismissMethods() {
		dismissUseCases.forEach { $0.pause() }
	}
	
	func dismiss(animated: Bool) {
		deactivateDismissMethods()
		delegate?.willDismissToastWith(id: toastId, by: self)
		
		animator.dismissAction(
			progress: 1,
			animated: animated,
			completion: { [weak self] _ in
				guard let self else { return }
				
				self.delegate?.didDismissToastWith(id: self.toastId, by: self)
			}
		)
	}
}

//MARK: - Private
private extension CxjToastDismisser {
	func createDismissUseCases() -> [ToastDismissUseCase] {
		config.dismissMethods.compactMap { method in
			CxjToastDismissUseCaseFactory.useCase(
				for: method,
				toastId: toastId,
				toastView: toastView,
				placement: config.layout.placement,
				animator: animator,
				delegate: self
			)
		}
	}
}

//MARK: - ToastDismissUseCaseDelegate
extension CxjToastDismisser: ToastDismissUseCaseDelegate {
	func didStartInteractive(by useCase: any ToastDismissUseCase) {
		pauseDismissMethods()
	}
	
	func didEndInteractive(by useCase: any ToastDismissUseCase) {
		activateDismissMethods()
	}
	
	func didUpdateRemainingDisplayingTime(
		_ time: TimeInterval,
		initialDisplayingTime: TimeInterval,
		by useCase: any ToastDismissUseCase
	) {
		delegate?.didUpdateRemainingDisplayingTime(time, initialDisplayingTime: initialDisplayingTime, forToastWithId: toastId, by: self)
	}
	
	func didFinish(useCase: any ToastDismissUseCase) {
		dismiss(animated: true)
	}
}
