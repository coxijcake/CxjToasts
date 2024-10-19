//
//  CxjToastDismisser+ByTouchUseCase.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import UIKit

extension CxjToastDismisser {
	final class DimissByTouchUseCase: ToastDismissUseCase {
		//MARK: - Props
		private let toastView: CxjToastView
		private let tapActionCompletion: VoidCompletion?
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
			target: self,
			action: #selector(handleToastTap)
		)
		
		//MARK: - Lifecycle
		init(
			toastView: CxjToastView,
			tapActionCompletion: VoidCompletion?,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.toastView = toastView
			self.tapActionCompletion = tapActionCompletion
			self.delegate = delegate
		}
		
		//MARK: - Public
		func activate() {
			removeGesture()
			addGesture()
		}
		
		func pause() {
			
		}
		
		func deactivate() {
			removeGesture()
		}
		
		//MARK: - Private
		private func addGesture() {
			toastView.addGestureRecognizer(tapGesture)
		}
		
		private func removeGesture() {
			toastView.removeGestureRecognizer(tapGesture)
		}
		
		@objc private func handleToastTap() {
			tapActionCompletion?()
			delegate?.didFinish(useCase: self)
		}
	}
}
