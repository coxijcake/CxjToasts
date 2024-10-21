//
//  CxjToastoordinator.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

protocol CxjToastCoordinatable {
	func presentToast()
}

final class CxjToastoordinator {
	let toast: CxjToast
	let presenter: CxjToastPresentable
	let dismisser: CxjToastDismissable
	
	init(
		toast: CxjToast,
		presenter: CxjToastPresentable,
		dismisser: CxjToastDismissable
	) {
		self.toast = toast
		self.presenter = presenter
		self.dismisser = dismisser
	}
}

extension CxjToastoordinator: CxjToastCoordinatable {
	func presentToast() {
		
	}
}

//@MainActor
final class CxjToastsCoordinator {
	typealias Toast = any CxjDisplayableToast
	
	static let shared: CxjToastsCoordinator = CxjToastsCoordinator()
	private init() {}
	
	private let publisher = MulticastPublisher<CxjToastDelegate>()
	
	private(set) var activeToasts: [Toast] = []
}

//MARK: - Public API
extension CxjToastsCoordinator {
	func showToast(
		_ toast: Toast,
		avoidTypeSpam: Bool
	) {
		if avoidTypeSpam,
		   let typeId = toast.typeId,
		   firstWith(typeId: typeId) != nil {
			return
		}
		
		toast.displayingState = .presenting
		activeToasts.append(toast)
		publisher.invoke { $0.willPresent(toast: toast) }
		
		CxjActiveToastsUpdater.updateLayout(
			activeToasts: activeToasts,
			progress: ToastLayoutProgress.max.value,
			on: toast.config.layout.placement,
			animation: toast.presenter.animator.presentAnimation,
			completion: nil
		)
		
		toast.presenter.present { [weak self, weak toast] _ in
			guard
				let self,
				let toast
			else { return }
			
			CxjActiveToastsUpdater.updateDisplayingState(
				activeToasts: self.activeToasts,
				on: toast.config.layout.placement
			)
			
			toast.displayingState = .presented
			toast.dismisser.activateDismissMethods()
			
			self.publisher.invoke { $0.didPresent(toast: toast) }
		}
	}
	
	func hideToast(_ identifiableToast: any CxjIdentifiableToast) {
		guard let toast: Toast = firstWith(id: identifiableToast.id) else { return }
		
		toast.dismisser.dismiss()
	}
	
	func firstWith(id: UUID) -> Toast? {
		activeToasts.first(where: { $0.id == id })
	}
	
	func firstWith(typeId: String) -> Toast? {
		activeToasts.first(where: { $0.typeId == typeId })
	}
}

//MARK: - Observing
extension CxjToastsCoordinator {
	public func add(observer: CxjToastDelegate) {
		publisher.add(observer)
	}
	
	public func remove(observer: CxjToastDelegate) {
		publisher.remove(observer)
	}
}

//MARK: - Private
private extension CxjToastsCoordinator {
	
}

//MARK: - CxjToastDismisserDelegate
extension CxjToastsCoordinator: CxjToastDismisserDelegate {
	func willDismissToastWith(id: UUID, by dismisser: CxjToastDismisser) {
		guard let toast: Toast = firstWith(id: id) else { return }
		
		let toastsToUpdate: [Toast] = activeToasts.filter { $0.id != toast.id }
		
		CxjActiveToastsUpdater.updateLayout(
			activeToasts: toastsToUpdate,
			progress: ToastLayoutProgress.max.value,
			on: toast.config.layout.placement,
			animation: toast.dismisser.animator.dismissAnimation,
			completion: nil
		)
		
		publisher.invoke { $0.willDismiss(toast: toast) }
	}
	
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismisser) {
		guard let toast: Toast = firstWith(id: id) else { return }
		
		dismisser.deactivateDismissMethods()
		toast.view.removeFromSuperview()
		toast.displayingState = .initial
		
		activeToasts.removeAll(where: { $0.id == toast.id })
		
		CxjActiveToastsUpdater.updateDisplayingState(
			activeToasts: activeToasts,
			on: toast.config.layout.placement
		)
		
		publisher.invoke { $0.didDismiss(toast: toast) }
	}
}
