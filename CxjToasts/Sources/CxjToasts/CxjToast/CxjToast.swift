//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToast {
    typealias ToastType = CxjToastType
    typealias ToastView = CxjToastView
	typealias SourceBackground = CxjToastSourceBackground
    typealias Configuration = CxjToastConfiguration
    typealias ContentView = CxjToastContentView
}

final class CxjToast: CxjDisplayableToast {
    //MARK: - Props
    let view: ToastView
	let sourceBackgroundView: SourceBackground?
    let config: Configuration
	let presenter: CxjToastPresentable
	let dismisser: CxjToastDismissable
	
	public let id: UUID
	
    var displayingState: CxjToastDisplayingState = .initial
	
    //MARK: - Lifecycle
    init(
		id: UUID,
        view: ToastView,
		sourceBackground: SourceBackground?,
        config: Configuration,
		presenter: CxjToastPresentable,
		dismisser: CxjToastDismissable
    ) {
		self.id = id
        self.view = view
		self.sourceBackgroundView = sourceBackground
        self.config = config
		self.presenter = presenter
		self.dismisser = dismisser
    }
}

//MARK: - Public common
extension CxjToast {
	var typeId: String { config.typeId }
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
