//
//  CxjToastDelegate.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

public protocol CxjToastDelegate: AnyObject {
	typealias Toast = any CxjIdentifiableToast
	
	func willPresent(toast: Toast)
	func didPresent(toast: Toast)
	func willDismiss(toast: Toast)
	func didDismiss(toast: Toast)
}

public extension CxjToastDelegate {
	func willPresent(toast: Toast) {}
	func didPresent(toast: Toast) {}
	func willDismiss(toast: Toast) {}
	func didDismiss(toast: Toast) {}
}
