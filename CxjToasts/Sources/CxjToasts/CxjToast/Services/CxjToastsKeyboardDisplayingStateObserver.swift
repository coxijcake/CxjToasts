//
//  CxjToastsKeyboardDisplayingStateObserver.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 15/12/2024.
//

import UIKit

//MARK: - DataSource
@MainActor
protocol CxjToastsKeyboardDisplayingStateObserverDataSource: AnyObject {
	func displayingToastsForObserver(_ observer: CxjToastsKeyboardDisplayingStateObserver) -> [any CxjDisplayableToast]
}

//MARK: - Types
extension CxjToastsKeyboardDisplayingStateObserver {
	typealias Toast = any CxjDisplayableToast
	
	struct KeyboardInfo {
		let endRect: CGRect
		let duration: Double
		let curveValue: UInt
	}
}

@MainActor
final class CxjToastsKeyboardDisplayingStateObserver {
	weak var dataSource: CxjToastsKeyboardDisplayingStateObserverDataSource?
	
	init() {
		subscribeToNotifications()
	}
}

//MARK: - Keyboard displaying state handling
private extension CxjToastsKeyboardDisplayingStateObserver {
	func handleKeyboardDisplayingStateChangeWithNotification(_ notification: NSNotification) {
		guard
			let info: KeyboardInfo = keyboardUserInfoFromNotification(notification),
			let displayingToasts: [Toast] = dataSource?.displayingToastsForObserver(self),
			!displayingToasts.isEmpty
		else { return }
		
		for displayingToast in displayingToasts {
			guard
				shouldUpdateToasts(displayingToast, forKeyboardInfo: info)
			else { continue }
			
			updateToast(displayingToast, forKeyboardInfo: info)
		}
	}
	
	func updateToast(_ toast: Toast, forKeyboardInfo info: KeyboardInfo) {
		let sourceView = toast.config.sourceView
		let viewToConvert: UIView? = UIApplication.keyWindow
		let convertedKeyboardEndRect = sourceView.convert(info.endRect, to: sourceView.window)
		
		let keyboardOverlap: CGFloat = toast.view.frame.maxY - convertedKeyboardEndRect.origin.y
		
		guard keyboardOverlap > 0 else { return }
		
		let yTranslation: CGFloat = -(keyboardOverlap + 20)
		
//		let bottomConstraint: NSLayoutConstraint = toast.view.constraintsAffectingLayout(for: .vertical).first(where: { $0. })
		
		let changes: CxjVoidCompletion = { [weak toast] in
//			toast?.view.transform = CGAffineTransform(translationX: .zero, y: yTranslation)
		}
		
		UIView.animate(
			withDuration: info.duration,
			delay: .zero,
			options: .init(rawValue: info.curveValue),
			animations: changes
		)
	}
	
	func shouldUpdateToasts(_ toast: Toast, forKeyboardInfo info: KeyboardInfo) -> Bool {
		guard
			toast.config.sourceView.safeAreaInsets == UIApplication.keyWindow?.safeAreaInsets
		else { return false }
		
		return true
	}
	
	func keyboardUserInfoFromNotification(_ notification: NSNotification) -> KeyboardInfo? {
		guard
			let userInfo = notification.userInfo,
			let endRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
			let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
			let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
		else { return nil }
		
		return KeyboardInfo(
			endRect: endRect,
			duration: duration,
			curveValue: curveValue
		)
	}
}

//MARK: - Notifications
private extension CxjToastsKeyboardDisplayingStateObserver {
	func subscribeToNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func keyboardWillShow(_ notification: NSNotification) {
		handleKeyboardDisplayingStateChangeWithNotification(notification)
	}
	
	@objc func keyboardWillHide(_ notification: NSNotification) {
		handleKeyboardDisplayingStateChangeWithNotification(notification)
	}
}
