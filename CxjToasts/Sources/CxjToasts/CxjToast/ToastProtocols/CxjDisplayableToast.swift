//
//  CxjDisplayableToast.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import UIKit

protocol CxjDisplayableToast: CxjIdentifiableToast, ConfigableToast, Sendable {
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
