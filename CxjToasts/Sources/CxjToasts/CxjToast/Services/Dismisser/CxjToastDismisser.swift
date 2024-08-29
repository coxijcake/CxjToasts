//
//  CxjToastDismisser.swift
//
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastDismisser {
	typealias DimissMethod = CxjToastConfiguration.DismissMethod
	typealias Configuration = CxjToastConfiguration
	typealias Toast = CxjToastable
	typealias ToastView = CxjToastView
	typealias Animator = CxjToastAnimator
}

final class CxjToastDismisser {
	//MARK: - Props
	private let toastView: ToastView
	private let config: Configuration
	private let animator: Animator
	private let onDismiss: VoidCompletion
	
	private lazy var dismissUseCases: [ToastDismissUseCase] = createDismissUseCases()
	
	//MARK: - Lifecycle
	init(
		toastView: ToastView,
		config: Configuration,
		animator: CxjToastAnimator,
		onDismiss: @escaping VoidCompletion
	) {
		self.toastView = toastView
		self.config = config
		self.animator = animator
		self.onDismiss = onDismiss
	}
	
	deinit {
		print("OMG CxjToastDismisser deinit")
	}
}

//MARK: - Public
extension CxjToastDismisser {
	func activate() {
		dismissUseCases.forEach { $0.activate() }
	}
	
	func deactivate() {
		dismissUseCases.forEach { $0.activate() }
		dismissUseCases.removeAll()
	}
	
	func pause() {
		dismissUseCases.forEach { $0.pause() }
	}
}

//MARK: - Private
private extension CxjToastDismisser {
	func createDismissUseCases() -> [ToastDismissUseCase] {
		config.hidingMethods.compactMap { method in
			CxjToastDismissUseCaseFactory.useCase(
				for: method,
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
		pause()
	}
	
	func didEndInteractive(by useCase: any ToastDismissUseCase) {
		activate()
	}
	
	func didFinish(useCase: any ToastDismissUseCase) {
		animator.hideAction { [weak self] _ in
			self?.onDismiss()
		}
	}
}
