//
//  CxjToastTheme.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTheme {
	public typealias ViewConfig = CxjToastViewConfiguration
	typealias ViewConfigurator = CxjToastViewConfigurator
	
	public typealias ToastConfig = CxjToastConfiguration
}

//MARK: - Themes Data
extension CxjToastTheme {
	public struct NativeToastData {
		let title: String
		let subtitle: String?
		let icon: UIImage?
		
		public init(
			title: String,
			subtitle: String?,
			icon: UIImage?
		) {
			self.title = title
			self.subtitle = subtitle
			self.icon = icon
		}
	}
}

//MARK: - Themes
public enum CxjToastTheme {
	case native(data: NativeToastData)
}
