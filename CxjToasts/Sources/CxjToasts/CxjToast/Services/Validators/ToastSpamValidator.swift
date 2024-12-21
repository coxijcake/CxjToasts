//
//  ToastSpamValidator.swift
//  
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import Foundation

extension ToastSpamValidator {
	enum ValidationResult {
		case passed
		case failed
	}
}

struct ToastSpamValidator {
	typealias Toast = any CxjDisplayableToast
	typealias Attributes = Set<CxjToastComparisonAttribute>
	
	let displayingToasts: [Toast]
	
	func couldBeDisplayedToast(_ toastToDisplay: Toast) -> Bool {
		switch toastToDisplay.config.spamProtection {
		case .on(comparisonCriteria: let comparisonCriteria):
			switch comparisonCriteria.logicOperation {
			case .or:
				return validateForEqualOneOfAttributes(
					comparisonCriteria.attibutes,
					toasts: displayingToasts,
					withToast: toastToDisplay
				) == .passed
			case .and:
				return validateForEqualAllAttributes(
					comparisonCriteria.attibutes,
					toasts: displayingToasts,
					withToast: toastToDisplay
				) == .passed
			}
		case .off:
			return true
		}
	}
	
	func validateForEqualAllAttributes(
		_ attributes: Attributes,
		toasts: [Toast],
		withToast targetToast: Toast
	) -> ValidationResult {
		for displayingToast in displayingToasts {
			let attributesComparator: ToastAttributesComparator = ToastAttributesComparator(
				lhsToast: displayingToast,
				rhsToast: targetToast,
				comparingAttributes: targetToast.config.coexistencePolicy.comparisonCriteria.attibutes
			)
			
			if attributesComparator.isAllAttributesEqual() {
				return .failed
			}
		}
		
		return .passed
	}
	
	func validateForEqualOneOfAttributes(
		_ attributes: Attributes,
		toasts: [Toast],
		withToast targetToast: Toast
	) -> ValidationResult {
		for displayingToast in displayingToasts {
			let attributesComparator: ToastAttributesComparator = ToastAttributesComparator(
				lhsToast: displayingToast,
				rhsToast: targetToast,
				comparingAttributes: targetToast.config.coexistencePolicy.comparisonCriteria.attibutes
			)
			
			if attributesComparator.isOneOfAttributesEqual() {
				return .failed
			}
		}
		
		return .passed
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
	
	func isOnTheSameSourceView(lhsToast: Toast, rhsToast: Toast) -> Bool {
		ToastSourceViewComparator(
			lhs: lhsToast.config.sourceView,
			rhs: rhsToast.config.sourceView
		).isEquals()
	}
}
