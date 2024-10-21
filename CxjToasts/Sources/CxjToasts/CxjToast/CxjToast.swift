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

public final class CxjToast: CxjDisplayableToast {
    //MARK: - Props
    let view: ToastView
    let config: Configuration
	let presenter: CxjToastPresentable
	let dismisser: CxjToastDismissable
	
	public let id: UUID
	
    var displayingState: CxjToastDisplayingState = .initial
	
    //MARK: - Lifecycle
    init(
		id: UUID,
        view: ToastView,
        config: Configuration,
		presenter: CxjToastPresentable,
		dismisser: CxjToastDismissable
    ) {
		self.id = id
        self.view = view
        self.config = config
		self.presenter = presenter
		self.dismisser = dismisser
    }
}

//MARK: - Presenting
extension CxjToast {
    public static func show(
        _ type: ToastType,
		avoidTypeSpam: Bool = false
    ) {
        let toast: CxjToast = CxjToastFactory.toastFor(
            type: type
        )
		
		CxjToastsCoordinator.shared.showToast(
			toast,
			avoidTypeSpam: avoidTypeSpam
		)
    }
}

//MARK: - Dismissing
extension CxjToast {
	public static func hideToast(
		_ identifiableToast: any CxjIdentifiableToast
	) {
		CxjToastsCoordinator.shared.hideToast(identifiableToast)
	}
}

//MARK: - Public common
extension CxjToast {
	public var typeId: String? { config.typeId }
	
	public static func firstWith(id: UUID) -> (any CxjIdentifiableToast)? {
		CxjToastsCoordinator.shared.firstWith(id: id)
	}
	
	public static func firstWith(typeId: String) -> (any CxjIdentifiableToast)? {
		CxjToastsCoordinator.shared.firstWith(typeId: typeId)
	}
}

//MARK: - Observing
extension CxjToast {
	public static func add(observer: CxjToastDelegate) {
		CxjToastsCoordinator.shared.add(observer: observer)
	}
	
	public static func remove(observer: CxjToastDelegate) {
		CxjToastsCoordinator.shared.remove(observer: observer)
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
