//
//  UIApplication+Extensions.swift
//  Example
//
//  Created by Nikita Begletskiy on 04/11/2024.
//

import UIKit

extension UIApplication {
	static var keyWindow: UIWindow? {
		if #available(iOS 13.0, *) {
			let allScenes = UIApplication.shared.connectedScenes
			
			for scene in allScenes {
				guard let windowScene = scene as? UIWindowScene else { continue }
				
				for window in windowScene.windows where window.isKeyWindow {
					return window
				}
			}
			
			return nil
		} else {
			return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
		}
	}
	
	static var interfaceOrientation: UIInterfaceOrientation? {
		if #available(iOS 13.0, *) {
			return keyWindow?.windowScene?.interfaceOrientation
		} else {
			return shared.statusBarOrientation
		}
	}
	
	static var safeAreaInsets: UIEdgeInsets {
		let defaultInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		return keyWindow?.safeAreaInsets ?? defaultInsets
	}
	
	static var rootViewController: UIViewController? {
		keyWindow?.rootViewController
	}
	
	static func topViewController(base: UIViewController? = rootViewController) -> UIViewController? {
		if let nav = base as? UINavigationController {
			return topViewController(base: nav.visibleViewController)
		} else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
			return topViewController(base: selected)
		} else if let presented = base?.presentedViewController {
			return topViewController(base: presented)
		}
		
		return base
	}
}
