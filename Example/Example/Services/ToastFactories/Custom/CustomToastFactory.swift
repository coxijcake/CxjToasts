//
//  CustomToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

@MainActor
enum CustomToastFactory {
	typealias ToastConfig = CxjToastConfiguration
	typealias ToastData = CxjToastType.CustomToastData
	
	static func toastDataForType(
		_ toastType: CustomToastType,
		customSourceView: UIView?
	) -> ToastData {
		let sourceView: UIView = customSourceView
		?? UIApplication.keyWindow
		?? UIApplication.topViewController()?.view
		?? UIView()
		
		switch toastType {
		case .bottomGradientedWithBlurredBackground:
			return BottomGradientWithBlurredBackgroundToastDataConfigurator.toastData(
				withSoureView: sourceView
			)
        case .sidePresentingToast:
            return SidePresentingToastDataConfigurator.toastData(
                withSourceView: sourceView
            )
		}
	}
}
