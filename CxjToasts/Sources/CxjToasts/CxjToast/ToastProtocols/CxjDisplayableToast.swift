//
//  CxjDisplayableToast.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

protocol CxjDisplayableToast: CxjIdentifiableToast, ComparableToast, Sendable {
	var presenter: CxjToastPresentable { get }
	var dismisser: CxjToastDismissable { get }
	var view: CxjToastView { get }
	var sourceBackgroundView: CxjToastSourceBackground? { get }
	var config: CxjToastConfiguration { get }
	
	@MainActor
	var displayingState: CxjToastDisplayingState { get set }
	@MainActor
	var isInteracting: Bool { get }
}

extension CxjDisplayableToast {
    var typeId: String { config.typeId }
    var placement: Placement { config.layout.placement }
    var sourceView: UIView { config.sourceView }
}
