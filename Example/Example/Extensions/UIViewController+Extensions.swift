//
//  UIViewController+Extensions.swift
//  Example
//
//  Created by Nikita Begletskiy on 04/11/2024.
//

import UIKit

extension UIViewController {
	static var storyboardName: String {
		return String(describing: self)
	}
	
	static func storyboardInstantiateInitialController() -> Self {
		let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
		let storyboardVC = storyboard.instantiateInitialViewController()
		return storyboardVC as! Self
	}
}
