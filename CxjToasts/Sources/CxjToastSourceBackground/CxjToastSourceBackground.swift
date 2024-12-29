//
//  CxjToastSourceBackground.swift
//
//
//  Created by Nikita Begletskiy on 31/10/2024.
//

import UIKit

public protocol CxjToastSourceBackground: UIView {
	typealias ActionCompletion = (() -> Void)
	typealias InteractionEvent = UIControl.Event
	
	func addInteractionAction(_ completion: ActionCompletion?, forEvent event: InteractionEvent)
}

