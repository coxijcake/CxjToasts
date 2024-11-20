//
//  CxjToastsCoordinator.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

//@MainActor
public final class CxjToastsCoordinator {
	public typealias IdentifiableToast = any CxjIdentifiableToast
	public typealias ToastType = CxjToastType
	typealias DisplayableToast = any CxjDisplayableToast
	
	public static let shared: CxjToastsCoordinator = CxjToastsCoordinator()
	private init() {}
	
	private let publisher = MulticastPublisher<CxjToastDelegate>()
	
	private(set) var activeToasts: [DisplayableToast] = []
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
		
		setupSourceBackgroundAction(forToast: toast)
		
		toast.presenter.present(animated: animated) { [weak self, weak toast] _ in
			guard
				let self,
				let toast
			else { return }
			
			CxjDisplayingToastsCoordinator.updateDismissMethodsFor(
				displayingToasts: self.activeToasts,
				linkedToToast: toast
			)
			
			toast.displayingState = .presented
			toast.dismisser.activateDismissMethods()
			
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
		
		toast.displayingState = .dismissing
		toast.dismisser.dismiss(animated: animated)
	}
	
	public func dismissToasts(_ identifiableToasts: [any CxjIdentifiableToast], animated: Bool) {
		identifiableToasts.forEach {
			dismissToast($0, animated: animated)
		}
	}
	
	public func dismissAll(animated: Bool) {
		dismissToasts(activeToasts, animated: animated)
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

//MARK: - SoucreBackground action handling
private extension CxjToastsCoordinator {
	func setupSourceBackgroundAction(forToast toast: DisplayableToast) {
		switch toast.config.sourceBackground?.interaction {
		case .disabled:
			toast.sourceBackgroundView?.isUserInteractionEnabled = false
		case .none:
			break
		case .enabled(action: let action):
			guard let action else { break }
			
			let actionHandling: CxjVoidCompletion? = {
				switch action.handling {
				case .none:
					return {}
				case .dismissToast:
					return { [weak self, weak toast] in
						guard let toast else { return }
						
						CxjToastsCoordinator.shared.dismissToast(toast, animated: true)
					}
				case .custom(let completion):
					return { [weak toast] in
						guard let toast else { return }
						completion?(toast)
					}
				}
			}()
			
			toast.sourceBackgroundView?.addInteractionAction(actionHandling, forEvent: action.touchEvent)
		}
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
		
		dismisser.deactivateDismissMethods()
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


//MARK: - ToastDisplayingProgress
extension CxjToastsCoordinator {
	struct ToastDisplayingProgress {
		private static let minValue: Float = .zero
		private static let maxValue: Float = 1.0
		
		static var min: ToastDisplayingProgress { ToastDisplayingProgress(value: minValue) }
		static var max: ToastDisplayingProgress { ToastDisplayingProgress(value: maxValue) }
		
		@ClampedProgress var value: Float
		
		var reverted: Float {
			_value.upperValue - value
		}
		
		init(value: Float) {
			self._value = ClampedProgress(value, ToastDisplayingProgress.minValue...ToastDisplayingProgress.maxValue)
		}
	}
}
