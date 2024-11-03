//
//  ToastSpamValidator.swift
//  
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import Foundation

struct ToastSpamValidator {
	typealias Toast = any CxjDisplayableToast
	
	let displayingToasts: [Toast]
	
	func couldBeDisplayedToast(_ toastToDisplay: Toast) -> Bool {
		switch toastToDisplay.config.spamProtection {
		case .on(comparingAttributes: let comparingAttributes):
			for displayingToast in displayingToasts {
				for comparingAttribute in comparingAttributes {
					switch comparingAttribute {
					case .type:
						guard
							!isEqualByType(lhsToast: displayingToast, rhsToast: toastToDisplay)
						else { return false }
					case .placement(let includingYOffset):
						guard
							!isEqualByPlacement(
								lhsToast: displayingToast,
								rhsToast: toastToDisplay,
								includingYOffset: includingYOffset
							)
						else { return false }
					}
				}
			}
			
			return true
		case .off:
			return true
		}
	}
	
	func isEqualByType(lhsToast: Toast, rhsToast: Toast) -> Bool {
		ToastTypeComparator(lhsToast: lhsToast, rhsToast: rhsToast)
			.isEqual()
	}
	
	func isEqualByPlacement(lhsToast: Toast, rhsToast: Toast, includingYOffset: Bool) -> Bool {
		let placementComparator: ToastPlacementComparator = ToastPlacementComparator(
			lhs: lhsToast.config.layout.placement,
			rhs: rhsToast.config.layout.placement
		)
		
		if includingYOffset {
			return placementComparator.isFullyEqauls()
		} else {
			return placementComparator.isEqualPlacementType()
		}
	}
}
