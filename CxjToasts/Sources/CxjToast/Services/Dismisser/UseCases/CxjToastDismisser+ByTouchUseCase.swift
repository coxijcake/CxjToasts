//
//  CxjToastDismisser+ByTouchUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import UIKit

extension CxjToastDismisser {
	@MainActor
	final class DimissByTouchUseCase {
		//MARK: - Props
		private let toastView: CxjToastView
		private let tapActionCompletion: CxjVoidCompletion?
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(handleToastTap)
		)
		
		//MARK: - Lifecycle
		init(
			toastView: CxjToastView,
			tapActionCompletion: CxjVoidCompletion?,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.toastView = toastView
			self.tapActionCompletion = tapActionCompletion
			self.delegate = delegate
		}
	}
}

//MARK: - ToastDismissUseCase
extension CxjToastDismisser.DimissByTouchUseCase: ToastDismissUseCase {
	var dismissMethod: ToastDimissMethod {
		.tap
	}
	
	func setupState(_ state: ToastDismisserState) {
		switch state {
		case .active: activate()
		case .inActive: deactivate()
		case .paused: pause()
		}
	}
}

//MARK: - Private
private extension CxjToastDismisser.DimissByTouchUseCase {
	func activate() {
		removeGesture()
		addGesture()
	}
	
	func pause() {
		
	}
	
	func deactivate() {
		removeGesture()
	}
	
	func addGesture() {
		toastView.addGestureRecognizer(tapGesture)
	}
	
	func removeGesture() {
		toastView.removeGestureRecognizer(tapGesture)
	}
	
	@objc func handleToastTap() {
		tapActionCompletion?()
		delegate?.didFinish(useCase: self)
	}
}
