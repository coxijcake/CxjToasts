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

@MainActor
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
			Task.detached {
				let delaySeconds: Double = customStrategy.delayBetweenToasts * Double(i)
				try await Task.sleep(nanoseconds: NSEC_PER_SEC * UInt64(delaySeconds))
				
				await presentToastType(toastType, animated: animated)
			}
		}
	}
}
