//
//  CxjToastDismisser.swift
//
//
//  Created by Nikita Begletskiy on 25/08/2024.
//

import UIKit

//MARK: - Delegate
protocol CxjToastDismisserDelegate: AnyObject {
	func willDismissToastWith(id: UUID, by dismisser: CxjToastDismisser)
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismisser)
}

//MARK: - Types
extension CxjToastDismisser {
	typealias DimissMethod = CxjToastConfiguration.DismissMethod
	typealias Configuration = CxjToastConfiguration
	typealias Toast = CxjToast
	typealias ToastView = CxjToastView
	typealias Animator = CxjToastDismissAnimator
}

final class CxjToastDismisser {
	//MARK: - Props
	private let toastId: UUID
	private let toastView: ToastView
	private let config: Configuration
	let animator: Animator
	
	private weak var delegate: CxjToastDismisserDelegate?
	
	private lazy var dismissUseCases: [ToastDismissUseCase] = createDismissUseCases()
	
	//MARK: - Lifecycle
	init(
		toastId: UUID,
		toastView: ToastView,
		config: Configuration,
		animator: CxjToastAnimator,
		delegate: CxjToastDismisserDelegate?
	) {
		self.toastId = toastId
		self.toastView = toastView
		self.config = config
		self.animator = animator
		self.delegate = delegate
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
	
	func dismiss() {
		delegate?.willDismissToastWith(id: toastId, by: self)
		
		animator.dismissAction(
			progress: 1,
			animated: true,
			completion: { [weak self] _ in
				guard let self else { return }
				
				self.delegate?.didDismissToastWith(id: self.toastId, by: self)
			}
		)
	}
	
	func pause() {
		dismissUseCases.forEach { $0.pause() }
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
		pause()
	}
	
	func didEndInteractive(by useCase: any ToastDismissUseCase) {
		activate()
	}
	
	func didFinish(useCase: any ToastDismissUseCase) {
		dismiss()
	}
}
