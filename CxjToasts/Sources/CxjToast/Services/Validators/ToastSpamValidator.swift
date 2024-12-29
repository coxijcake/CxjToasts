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
    typealias Toast = any SpamProtectableToast & ComparableToast
	typealias Attributes = Set<CxjToastComparisonAttribute>
	
	let displayingToasts: [Toast]
	
	func couldBeDisplayedToast(_ toastToDisplay: Toast) -> Bool {
		switch toastToDisplay.spamProtection {
		case .on(comparisonCriteria: let comparisonCriteria):
            let comparingAttributes: Attributes = comparisonCriteria.attibutes
            
			switch comparisonCriteria.logicOperation {
			case .or:
				return validateForEqualOneOfAttributes(
					comparisonCriteria.attibutes,
					toasts: displayingToasts,
                    withToast: toastToDisplay,
                    comparingAttributes: comparingAttributes
				) == .passed
			case .and:
				return validateForEqualAllAttributes(
					comparisonCriteria.attibutes,
					toasts: displayingToasts,
					withToast: toastToDisplay,
                    comparingAttributes: comparingAttributes
				) == .passed
			}
		case .off:
			return true
		}
	}
	
	private func validateForEqualAllAttributes(
		_ attributes: Attributes,
		toasts: [Toast],
		withToast targetToast: Toast,
        comparingAttributes: Attributes
	) -> ValidationResult {
		for displayingToast in displayingToasts {
			let attributesComparator: ToastAttributesComparator = ToastAttributesComparator(
                lhsToast: displayingToast,
                rhsToast: targetToast,
                comparingAttributes: comparingAttributes
			)
			
			if attributesComparator.isAllAttributesEqual() {
				return .failed
			}
		}
		
		return .passed
	}
	
    private func validateForEqualOneOfAttributes(
		_ attributes: Attributes,
		toasts: [Toast],
		withToast targetToast: Toast,
        comparingAttributes: Attributes
	) -> ValidationResult {
		for displayingToast in displayingToasts {
			let attributesComparator: ToastAttributesComparator = ToastAttributesComparator(
                lhsToast: displayingToast,
                rhsToast: targetToast,
                comparingAttributes: comparingAttributes
			)
			
			if attributesComparator.isOneOfAttributesEqual() {
				return .failed
			}
		}
		
		return .passed
	}
	
    private func isEqualByType(lhsToast: Toast, rhsToast: Toast) -> Bool {
        ToastTypeComparator(
            lhsToastTypeId: lhsToast.typeId,
            rhsToastTypeId: rhsToast.typeId
        )
        .isEqual()
	}
	
    private func isEqualByPlacement(lhsToast: Toast, rhsToast: Toast, includingYOffset: Bool) -> Bool {
		let placementComparator: ToastPlacementComparator = ToastPlacementComparator(
			lhs: lhsToast.placement,
			rhs: rhsToast.placement
		)
		
		if includingYOffset {
			return placementComparator.isFullyEqauls()
		} else {
			return placementComparator.isEqualPlacementType()
		}
	}
	
    private func isOnTheSameSourceView(lhsToast: Toast, rhsToast: Toast) -> Bool {
		ToastSourceViewComparator(
			lhs: lhsToast.sourceView,
			rhs: rhsToast.sourceView
		).isEquals()
	}
}
