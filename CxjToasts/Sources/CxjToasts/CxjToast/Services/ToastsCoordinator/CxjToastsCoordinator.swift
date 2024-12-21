//
//  CxjToastsCoordinator.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

@MainActor
public final class CxjToastsCoordinator {
	public typealias IdentifiableToast = any CxjIdentifiableToast
	public typealias ToastType = CxjToastType
	typealias DisplayableToast = any CxjDisplayableToast
	
	public static let shared: CxjToastsCoordinator = CxjToastsCoordinator()
	
	private let keyboardDisplayingStateObserver: CxjToastsKeyboardDisplayingStateHandler = CxjToastsKeyboardDisplayingStateHandler()
	
	private let publisher = MulticastPublisher<CxjToastDelegate>()
	
	private(set) var activeToasts: [DisplayableToast] = []
	
	private init() {
		baseConfigure()
	}
}

//MARK: - Public API
extension CxjToastsCoordinator {
	public func showToast(
		type toastType: ToastType,
		animated: Bool = true
	) {
		let toast: CxjToast = CxjToastFactory.toastFor(
			type: toastType
		)
		
		showToast(toast, animated: animated)
	}
	
	func showToast(
		_ toast: DisplayableToast,
		animated: Bool
	) {
		let spamValidator: ToastSpamValidator = ToastSpamValidator(displayingToasts: activeToasts)
		guard spamValidator.couldBeDisplayedToast(toast) else { return }
		
		toast.displayingState = .presenting
		activeToasts.append(toast)
		publisher.invoke { $0.willPresent(toast: toast) }
		
		CxjDisplayingToastsCoordinator.updateLayoutFor(
			displayingToasts: activeToasts,
			linkedToToast: toast,
			withProgress: ToastLayoutProgress.max.value,
			animation: toast.presenter.animator.presentAnimation,
			completion: nil
		)
		
		SourceBackgroundActionConfigurator.configureActionForToast(toast)
		
		toast.dismisser.configureDismissMethods()
        presentToast(toast, animated: animated)
        
        if let hapticFeedback = toast.config.hapticFeeback {
            CxjToastHapticImpacter.impactFeedback(hapticFeedback)
        }
	}
}

//MARK: - Presenting
private extension CxjToastsCoordinator {
    func presentToast(_ toast: DisplayableToast, animated: Bool) {
        toast.presenter.present(
            animated: animated,
            keyboardState: keyboardDisplayingStateObserver.keyboardDisplayingState
        ) { [weak self, weak toast] _ in
            guard
                let self,
                let toast
            else { return }
            
            CxjDisplayingToastsCoordinator.updateDismissMethodsFor(
                displayingToasts: self.activeToasts,
                linkedToToast: toast
            )
            
            toast.displayingState = .presented
            toast.dismisser.setupDimissMethods(state: .active)
            
            self.publisher.invoke { $0.didPresent(toast: toast) }
        }
    }
}

//MARK: - Dismissing
extension CxjToastsCoordinator {
	public func dismissToast(_ identifiableToast: any CxjIdentifiableToast, animated: Bool) {
		guard 
			let toast: DisplayableToast = first(withId: identifiableToast.id)
		else { return }
		
		dismissDisplayableToast(toast, animated: animated)
	}
	
	public func dismissToasts(_ identifiableToasts: [any CxjIdentifiableToast], animated: Bool) {
		identifiableToasts.forEach {
			dismissToast($0, animated: animated)
		}
	}
	
	public func dismissToast(withId toastId: UUID, animated: Bool) {
		guard let toast: DisplayableToast = first(withId: toastId) else { return }
		
		dismissDisplayableToast(toast, animated: animated)
	}
	
	public func dismissToasts(withIds toastIds: [UUID], animated: Bool) {
		toastIds.forEach {
			dismissToast(withId: $0, animated: animated)
		}
	}
	
	public func dismissAll(animated: Bool) {
		dismissToasts(activeToasts, animated: animated)
	}
	
	private func dismissDisplayableToast(_ toast: DisplayableToast, animated: Bool) {
		toast.displayingState = .dismissing
		toast.dismisser.dismiss(animated: animated)
	}
}

//MARK: - Toasts searching
extension CxjToastsCoordinator {
	public func firstWith(id: UUID) -> IdentifiableToast? {
		activeToasts.first(where: { $0.id == id })
	}
	
	public func first<T>(withId id: UUID) -> T? {
		firstWith(id: id) as? T
	}
	
	public func firstWith(typeId: String) -> IdentifiableToast? {
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

//MARK: - Base configuration
private extension CxjToastsCoordinator {
	func baseConfigure() {
		keyboardDisplayingStateObserver.dataSource = self
	}
}

//MARK: - CxjToastDismisserDelegate
extension CxjToastsCoordinator: CxjToastDismisserDelegate {
	func willDismissToastWith(id: UUID, by dismisser: CxjToastDismissable) {
		guard
			let toast: DisplayableToast = first(withId: id)
		else { return }
		
		let toastsToUpdate: [DisplayableToast] = activeToasts.filter { $0.id != toast.id }
		
		CxjDisplayingToastsCoordinator.updateLayoutFor(
			displayingToasts: toastsToUpdate,
			linkedToToast: toast,
			withProgress: ToastLayoutProgress.max.value,
			animation: toast.dismisser.animator.dismissAnimation,
			completion: nil
		)
		
		publisher.invoke { $0.willDismiss(toast: toast) }
	}
	
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismissable) {
		guard
			let toast: DisplayableToast = first(withId: id)
		else { return }
		
		toast.dismisser.setupDimissMethods(state: .inActive)
		toast.view.removeFromSuperview()
		toast.sourceBackgroundView?.removeFromSuperview()
		toast.displayingState = .initial
		
		activeToasts.removeAll(where: { $0.id == toast.id })
		
		CxjDisplayingToastsCoordinator.updateDismissMethodsFor(
			displayingToasts: activeToasts,
			linkedToToast: toast
		)
		
		publisher.invoke { $0.didDismiss(toast: toast) }
	}
	
	func didUpdateRemainingDisplayingTime(
		_ time: TimeInterval,
		initialDisplayingTime: TimeInterval,
		forToastWithId toastId: UUID,
		by dismisser: any CxjToastDismissable
	) {
		guard
			let toast: DisplayableToast = first(withId: toastId)
		else { return }
		
		let progressValue: Float = Float(time / initialDisplayingTime)
		let progress: ToastDisplayingProgress = ToastDisplayingProgress(value: progressValue)
		
		toast.view.updateForRemainingDisplayingTime(time, animated: true)
		toast.view.updateForDismissingProgress(progress.reverted, animated: true)
	}
}

//MARK: - CxjToastsKeyboardDisplayingStateHandler.DataSource
extension CxjToastsCoordinator: CxjToastsKeyboardDisplayingStateHandler.DataSource {
	func displayingToastsForObserver(_ observer: CxjToastsKeyboardDisplayingStateHandler) -> [any CxjDisplayableToast] {
		activeToasts
	}
}
