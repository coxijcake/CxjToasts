//
//  CxjToastDismisser.swift
//
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import UIKit

//MARK: - Delegate
@MainActor
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
@MainActor
protocol CxjToastDismissable: Sendable {
	var animator: CxjToastDismissAnimator { get }
	
	func configureDismissMethods()
	func setupDimissMethods(_ methods: Set<ToastDimissMethod>, state: ToastDismisserState)
	func dismiss(animated: Bool)
}

extension CxjToastDismissable {
	func setupDimissMethods(_ methods: Set<ToastDimissMethod> = ToastDimissMethod.allUnqiueCases, state: ToastDismisserState) {
		setupDimissMethods(methods, state: state)
	}
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
final class CxjToastDismisser {
	//MARK: - Props
	private let toastId: UUID
	private let toastView: ToastView
	private let sourceBackgroundView: CxjToastSourceBackground?
	private let config: Configuration
	
	private var dismissUseCases: [ToastDismissUseCase] = []
	
	private weak var delegate: CxjToastDismisserDelegate?
	
	let animator: Animator
	
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
extension CxjToastDismisser: CxjToastDismissable {
	func configureDismissMethods() {
		dismissUseCases = config.dismissMethods.compactMap { method in
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
	
	func setupDimissMethods(_ methods: Set<ToastDimissMethod>, state: ToastDismisserState) {
		dismissUseCases.forEach {
			methods.contains($0.dismissMethod)
			? $0.setupState(state)
			: ()
		}
	}
	
	func dismiss(animated: Bool) {
		setupDimissMethods(state: .inActive)
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

//MARK: - ToastDismissUseCaseDelegate
extension CxjToastDismisser: ToastDismissUseCaseDelegate {
	func didStartInteractive(by useCase: any ToastDismissUseCase) {
		setupDimissMethods([.time], state: .paused)
	}
	
	func didEndInteractive(by useCase: any ToastDismissUseCase) {
		setupDimissMethods([.time], state: .active)
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
