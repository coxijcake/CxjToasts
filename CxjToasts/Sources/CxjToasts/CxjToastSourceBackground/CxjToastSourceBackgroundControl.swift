//
//  CxjToastSourceBackgroundControl.swift
//
//
//  Created by Nikita Begletskiy on 31/10/2024.
//

import UIKit

final class CxjToastSourceBackgroundControl: UIControl {
	private var interactionCompletion: VoidCompletion?
		
	@objc private func handleInteraction() {
		interactionCompletion?()
	}
}

//MARK: - CxjToastSourceBackground
extension CxjToastSourceBackgroundControl: CxjToastSourceBackground {
	func addInteractionAction(_ completion: ActionCompletion?, forEvent uiEvent: InteractionEvent) {
		self.interactionCompletion = completion
		self.addTarget(self, action: #selector(handleInteraction), for: uiEvent)
	}
}
