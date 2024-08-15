//
//  CxjToastView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public final class CxjToastView: UIView {
	private let config: CxjToastViewConfiguration
	private let contentView: CxjToastContentView
	
	public init(
		config: CxjToastViewConfiguration,
		contentView: CxjToastContentView
	) {
		self.config = config
		self.contentView = contentView
	}
	
	
}
