//
//  CxjDisplayableToast.swift
//
//
//  Created by Nikita Begletskiy on 21/10/2024.
//

import Foundation

protocol CxjDisplayableToast: CxjIdentifiableToast {
	var presenter: CxjToastPresentable { get }
	var dismisser: CxjToastDismissable { get }
	var view: CxjToastView { get }
	var sourceBackground: CxjToastSourceBackground? { get }
	var config: CxjToastConfiguration { get }
	
	var displayingState: CxjToastDisplayingState { get set }
}
