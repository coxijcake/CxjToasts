//
//  TemplatedToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

@MainActor
enum TemplatedToastFactory {
    typealias ToastTemplate = CxjToastTemplate
    
	static func toastTemplateForType(
		_ templateType: TemplatedToastType,
		customSourceView: UIView? = nil
	) -> ToastTemplate {
		switch templateType {
		case .native:
			return nativeToast()
		case .bottomPrimary:
			return bottomPrimaryToast(
				customSourceView: customSourceView
			)
		case .topStraight:
			return topStraightToast(
				customSourceView: customSourceView
			)
        case .minimalizedGlobalStatus:
            return minimalizedGlobalStatus()
        case .compactActionDescription:
            return compactActionDescription(
                customSourceView: customSourceView
            )
		case .actionableEvent:
			return actionableEventToast(
				customSourceView: customSourceView
			)
		case .undoAction:
			return undoActionToast(
				customSourceView: customSourceView
			)
		}
	}
}
