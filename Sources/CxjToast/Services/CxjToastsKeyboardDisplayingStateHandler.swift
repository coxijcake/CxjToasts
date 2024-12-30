//
//  CxjToastsKeyboardDisplayingStateObserver.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import UIKit

//MARK: - DataSource
extension CxjToastsKeyboardDisplayingStateHandler {
	@MainActor
	protocol DataSource: AnyObject {
		func displayingToastsForObserver(_ observer: CxjToastsKeyboardDisplayingStateHandler) -> [any CxjDisplayableToast]
	}
}

//MARK: - Types
extension CxjToastsKeyboardDisplayingStateHandler {
	typealias Toast = any CxjDisplayableToast
}

enum CxjKeyboardDisplayingState {
	struct DisplayingData {
		let rect: CGRect
		let animationDuration: Double
		let curveValue: UInt
	}
	
	case displaying(data: DisplayingData)
	case hiden
}

@MainActor
final class CxjToastsKeyboardDisplayingStateHandler {
	typealias KeyboardInfo = CxjKeyboardDisplayingState.DisplayingData
	
	private(set) var keyboardDisplayingState: CxjKeyboardDisplayingState = .hiden
	
	weak var dataSource: DataSource?
	
	init() {
		subscribeToNotifications()
	}
}

//MARK: - Keyboard displaying state handling
private extension CxjToastsKeyboardDisplayingStateHandler {
	func handleKeyboardPresentingWithNotification(_ notification: NSNotification) {
		guard
			let info: KeyboardInfo = keyboardInfoFromNotification(notification)
		else { return }
		
		setupKeyboardDisplayingState(.displaying(data: info), animated: true)
	}
	
	func handleKeyboardDismissingWithNotification(_ notification: NSNotification) {
		setupKeyboardDisplayingState(.hiden, animated: true)
	}
	
	func setupKeyboardDisplayingState(_ state: CxjKeyboardDisplayingState, animated: Bool) {
		keyboardDisplayingState = state
		updateDisplayingToasts(
			withKeyboardState: state,
			animated: animated
		)
	}
	
	func updateDisplayingToasts(
		withKeyboardState keyboardState: CxjKeyboardDisplayingState,
		animated: Bool
	) {
		dataSource?.displayingToastsForObserver(self).forEach {
			$0.presenter.updateForKeyboardState(keyboardState, animated: animated)
		}
	}
	
	func keyboardInfoFromNotification(_ notification: NSNotification) -> KeyboardInfo? {
		guard
			let userInfo = notification.userInfo,
			let endRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
			let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
			let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
		else { return nil }
		
		return KeyboardInfo(
			rect: endRect,
			animationDuration: duration,
			curveValue: curveValue
		)
	}
}

//MARK: - Notifications
private extension CxjToastsKeyboardDisplayingStateHandler {
	func subscribeToNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		handleKeyboardPresentingWithNotification(notification)
	}
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		handleKeyboardDismissingWithNotification(notification)
	}
}
