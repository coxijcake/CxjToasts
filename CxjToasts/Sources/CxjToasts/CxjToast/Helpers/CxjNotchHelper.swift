//
//  CxjNotchHelper.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

public enum CxjNotchHelper {
	public static let beforeNotchModelSafeAreaHeight: CGFloat = 20
	public static let afterNotchModelSafeAreaHeight: CGFloat = 59 // dynamic island
	
	public static let notchSize: CGSize = CGSize(width: 209, height: 26)
	public static let estimatedBottomCornerRadius: CGFloat = 30
	public static let backgroundColor: UIColor = .black
	
	public static var isNotchInDefaultPosition: Bool {
		guard
			hasNotch,
			UIApplication.interfaceOrientation == .portrait
		else { return false }
		
		return true
	}
	
	public static var hasNotch: Bool {
		if #available(iOS 13.1, *) {
			var safeAreaInset: CGFloat?
			let orientation = UIApplication.interfaceOrientation
			
			if (orientation == .portrait) {
				safeAreaInset = UIApplication.safeAreaInsets.top
			} else if (orientation == .landscapeLeft) {
				safeAreaInset = UIApplication.safeAreaInsets.left
			} else if (orientation == .landscapeRight) {
				safeAreaInset = UIApplication.safeAreaInsets.right
			}
			
			guard let safeAreaInset else { return false }
			
			let isPossibleToHaveNotch: Bool = 
			safeAreaInset > Self.beforeNotchModelSafeAreaHeight
			&&
			safeAreaInset < Self.afterNotchModelSafeAreaHeight
			
			return isPossibleToHaveNotch
		} else {
			return false
		}
	}
}
