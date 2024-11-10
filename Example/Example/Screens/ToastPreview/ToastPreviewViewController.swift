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
		let toastType: CxjToastType
	}
}

final class ToastPreviewViewController: UIViewController {	
	var input: Input!
	
	@IBAction func closeButtonPressed() {
		dismiss(animated: true)
	}
	
	@IBAction func presentButtonPressed() {
		ToastPresenter.presentToastWithType(
			input.toastType,
			strategy: toastPresentingStrategy(),
			animated: true
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
