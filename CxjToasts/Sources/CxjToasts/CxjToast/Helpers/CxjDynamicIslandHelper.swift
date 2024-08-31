//
//  CxjDynamicIslandHelper.swift
//  
//
//  Created by Nikita Begletskiy on 31/08/2024.
//

import UIKit

// https://developer.apple.com/design/human-interface-guidelines/live-activities
public enum CxjDynamicIslandHelper {
    public static let topOffset: CGFloat = 27
    public static let estimatedMinHeight: CGFloat = 37
    public static let minWidth: CGFloat = 126
    public static let cornerRadius: CGFloat = 44
    public static let backgroundColor: UIColor = .black
    public static let minSafeAreaHeight: CGFloat = 59
    
    public static var isDynamicIslandEnabled: Bool {
        if #available(iOS 16.1, *) {
            //TODO: - Add orientation support
            guard
                UIDevice.current.userInterfaceIdiom == .phone
            else { return false }
                    
            return UIApplication.safeAreaInsets.top >= Self.minSafeAreaHeight
        } else {
            return false
        }
    }
}
