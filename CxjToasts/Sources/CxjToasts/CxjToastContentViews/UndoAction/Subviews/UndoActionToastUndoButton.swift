//
//  UndoActionToastUndoButton.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 03/12/2024.
//

import UIKit

extension UndoActionToastUndoButton {
	struct ButtonConfig {
		enum Title {
			case plain(text: String, color: UIColor, font: UIFont)
			case attributed(text: NSAttributedString)
		}
		
		let title: Title
	}
}

final class UndoActionToastUndoButton: CxjInteractiveBounceButton {
	override var alphaOnTouch: CGFloat { 0.975 }
	override var scaleOnTouch: CGFloat { 0.925 }
}

//MARK: - Configuration
extension UndoActionToastUndoButton {
	func setupConfig(_ config: ButtonConfig, forState controlState: UIControl.State) {
		switch config.title {
		case .plain(text: let text, color: let color, font: let font):
			setTitle(text, for: controlState)
			setTitleColor(color, for: controlState)
			titleLabel?.font = font
		case .attributed(text: let text):
			setAttributedTitle(text, for: controlState)
		}
	}
}
