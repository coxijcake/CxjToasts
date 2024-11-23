//
//  CxjColorizedBackgroundViewConfigurator.swift
//
//
//  Created by Nikita Begletskiy on 19/10/2024.
//

import UIKit

@MainActor
enum CxjColorizedBackgroundViewConfigurator {
	static func backgroundViewFor(color: UIColor) -> UIView {
		let view: UIView = UIView()
		view.backgroundColor = color
		
		return view
	}
}
