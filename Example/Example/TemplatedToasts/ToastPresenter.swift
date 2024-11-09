//
//  ToastPresenter.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

enum ToastPresetingStrategy {
	struct CustomPresentingStrategy {
		let presentsCount: Int
		let delayBetweenToasts: TimeInterval
	}
	
	case `default`
	case custom(strategy: CustomPresentingStrategy)
}

enum ToastPresenter {
	static func presentToastWithType(
		_ toastType: CxjToastType,
		strategy: ToastPresetingStrategy,
		animated: Bool
	) {
		switch strategy {
		case .default:
			presentToastType(toastType, animated: animated)
		case .custom(let strategy):
			presentToastType(
				toastType,
				withCustomStrategy: strategy,
				animated: animated
			)
		}
	}
	
	private static func presentToastType(_ toastType: CxjToastType, animated: Bool) {
		CxjToastsCoordinator.shared.showToast(
			type: toastType,
			animated: animated
		)
	}
	
	private static func presentToastType(
		_ toastType: CxjToastType,
		withCustomStrategy customStrategy: ToastPresetingStrategy.CustomPresentingStrategy,
		animated: Bool
	) {
		for i in 0..<customStrategy.presentsCount {
			DispatchQueue.main.asyncAfter(deadline: .now() + customStrategy.delayBetweenToasts * TimeInterval(i)) {
				presentToastType(toastType, animated: animated)
			}
		}
	}
}
