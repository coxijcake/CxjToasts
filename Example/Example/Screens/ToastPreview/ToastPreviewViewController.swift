//
//  ToastPreviewViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 04/11/2024.
//

import UIKit
import CxjToasts

//MARK: - Types
extension ToastPreviewViewController {
	struct Input {
		let toastType: ToastType
	}
}

final class ToastPreviewViewController: UIViewController {
	//MARK: - Subviews
	@IBOutlet weak var centerContainerView: UIView!
	@IBOutlet weak var textField: UITextField!
	
	//MARK: - Props
	var input: Input!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		textField.delegate = self
	}
	
	//MARK: - Actions
	@IBAction func closeButtonPressed() {
		dismiss(animated: true)
	}
	
	@IBAction func backgroundViewPresentButtonPressed() {
		try? presentInputToast(
			fromView: view,
			animated: true
		)
	}
	
	@IBAction func centerContainerViewPresentButtonPressed() {
		try? presentInputToast(
			fromView: centerContainerView,
			animated: true
		)
	}
}

//MARK: - Presenting
private extension ToastPreviewViewController {
	func presentInputToast(fromView sourceView: UIView, animated: Bool) throws {
		let toastType: CxjToastType = try ToastFactory.cxjToastTypeFor(
			toastType: input.toastType,
			customSourceView: sourceView
		)
		
		let strategy: ToastPresetingStrategy = toastPresentingStrategy()
		
		ToastPresenter.presentToastWithType(
			toastType,
			strategy: strategy,
			animated: animated
		)
	}
}

//MARK: - Toast presenting strategy
private extension ToastPreviewViewController {
	func toastPresentingStrategy() -> ToastPresetingStrategy {
		.custom(
			strategy: .init(
				presentsCount: 1,
				delayBetweenToasts: 1.0
			)
		)
	}
}

extension ToastPreviewViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
