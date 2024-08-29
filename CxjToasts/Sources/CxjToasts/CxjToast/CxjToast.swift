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
}

public final class CxjToast: CxjToastIdentifiable {
    //MARK: - Props
	public let id: UUID = UUID()
    let view: ToastView
    let config: Configuration
	
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
	
	private static var activeToasts: Set<CxjToast> = []
	
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
        _ type: ToastType,
        with content: ContentView
    ) {
        let toast: CxjToast = CxjToastFactory.toastFor(
            type: type,
            content: content
        )
		
		activeToasts.insert(toast)
		publisher.invoke { $0.willPresent(toast: toast) }
		
		toast.presenter.present { [weak toast] _ in
			guard let toast else { return }
			
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
		
		CxjToast.publisher.invoke { $0.willDismiss(toast: toast) }
	}
	
	func didDismissToastWith(id: UUID, by dismisser: CxjToastDismisser) {
		guard let toast = CxjToast.firstWith(id: id) else { return }
		
		dismisser.deactivate()
		toast.view.removeFromSuperview()
		
		CxjToast.activeToasts.remove(toast)
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
