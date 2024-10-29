//
//  CxjToastTemplate.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTemplate {
	public typealias ViewConfig = CxjToastViewConfiguration
	public typealias ToastConfig = CxjToastConfiguration
}

//MARK: - Themes
public enum CxjToastTemplate {
	case native(data: NativeToastData)
	case bottomPrimary(data: BottomPrimaryToastData)
}