//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Types
public extension CxjToast {
    typealias ToastType = CxjToastType
    typealias ToastView = CxjToastView
    typealias Configuration = CxjToastConfiguration
    typealias ContentView = CxjToastContentView
    
    enum DisplayingState: String {
        case initial
        case presenting
        case presented
        case dismissing
    }
}

public final class CxjToast: CxjToastIdentifiable {
    //MARK: - Props
	public let id: UUID = UUID()
    let view: ToastView
    let config: Configuration
    
    private(set) var displayingState: DisplayingState = .initial
	
	private static let publisher = CxjMulticastPublisher<CxjToastDelegate>()
	
	private(set) lazy var animator: CxjToastAnimator = CxjToastAnimator(
		toastView: view,
		config: config
	)
	
	private(set) lazy var presenter: CxjToastPresenter = CxjToastPresenter(
		config: config,
		toastView: view,
		animator: animator
	)
	
	private(set) lazy var dismisser: CxjToastDismisser = CxjToastDismisser(
		toastId: id,
		toastView: view,
		config: config,
		animator: animator,
		delegate: self
	)
	
    private(set) static var activeToasts: [CxjToast] = []
	
    //MARK: - Lifecycle
    init(
        view: ToastView,
        config: Configuration
    ) {
        self.view = view
        self.config = config
    }
}

//MARK: - Public Presenting
extension CxjToast {
    public static func show(
        _ type: ToastType
    ) {
        let toast: CxjToast = CxjToastFactory.toastFor(
            type: type
        )
		
        toast.displayingState = .presenting
        activeToasts.append(toast)
		publisher.invoke { $0.willPresent(toast: toast) }
		
        CxjActiveToastsUpdater.updateLayout(
			activeToasts: activeToasts, 
			progress: 1.0,
            on: toast.config.layout.placement,
            animation: toast.presenter.animator.presentAnimation,
            completion: nil
        )
        
		toast.presenter.present { [weak toast] _ in
			guard let toast else { return }
            
            CxjActiveToastsUpdater.updateDisplayingState(
                activeToasts: activeToasts,
                on: toast.config.layout.placement
            )
			
            toast.displayingState = .presented
            toast.dismisser.activate()
			
			publisher.invoke { $0.didPresent(toast: toast) }
		}
    }
}

//MARK: - Dismissing
extension CxjToast {
	public static func hideToast(
		with id: UUID
	) {
		guard let toast = CxjToast.firstWith(id: id) else { return }
		
		toast.dismisser.dismiss()
	}
}

//MARK: - Observing
extension CxjToast {
	public static func add(observer: CxjToastDelegate) {
		publisher.add(observer)
	}
	
	public static func remove(observer: CxjToastDelegate) {
		publisher.remove(observer)
	}
}

//MARK: - Private
private extension CxjToast {
	static func firstWith(id: UUID) -> CxjToast? {
		activeToasts.first(where: { $0.id == id })
	}
}

//MARK: - CxjToastDismisserDelegate
extension CxjToast: CxjToastDismisserDelegate {
	func willDismissToastWith(id: UUID, by dismisser: CxjToastDismisser) {
		guard let toast = CxjToast.firstWith(id: id) else { return }
		
        let toastsToUpdate = CxjToast.activeToasts.filter { $0 != toast }
        toast.displayingState = .dismissing
        
        CxjActiveToastsUpdater.updateLayout(
			activeToasts: toastsToUpdate,
			progress: 1.0,
            on: toast.config.layout.placement,
            animation: toast.dismisser.animator.dismissAnimation,
            completion: nil
        )
        
		CxjToast.publisher.invoke { $0.willDismiss(toast: toast) }
	}
	
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismisser) {
		guard let toast = CxjToast.firstWith(id: id) else { return }
		
		dismisser.deactivate()
		toast.view.removeFromSuperview()
        toast.displayingState = .initial
		
        CxjToast.activeToasts.removeAll(where: { $0 == toast })
		
		CxjActiveToastsUpdater.updateDisplayingState(
			activeToasts: CxjToast.activeToasts,
			on: toast.config.layout.placement
		)
		
		CxjToast.publisher.invoke { $0.didDismiss(toast: toast) }
	}
}

//MARK: - Equatable
extension CxjToast: Equatable {
	public static func ==(lhs: CxjToast, rhs: CxjToast) -> Bool {
		lhs.id == rhs.id
	}
}

//MARK: - Hashable
extension CxjToast: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
