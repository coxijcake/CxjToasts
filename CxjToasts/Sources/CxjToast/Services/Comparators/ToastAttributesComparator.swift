//
//  ToastAttributesComparator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/11/2024.
//

import UIKit

extension ToastAttributesComparator {
	enum ValidationResult {
		case passed
		case failed
	}
}

struct ToastAttributesComparator {
	typealias ComparisonAttribute = CxjToastComparisonAttribute
	
    let lhsToast: ComparableToast
    let rhsToast: ComparableToast
	let comparingAttributes: Set<ComparisonAttribute>
	
	func isAllAttributesEqual() -> Bool {
		let attributesCount: Int = comparingAttributes.count
		var equalAttributesCount: Int = 0
		
		for comparingAttribute in comparingAttributes {
			switch comparingAttribute {
			case .type:
                let typeComparator: ToastTypeComparator = ToastTypeComparator(
                    lhsToastTypeId: lhsToast.typeId,
                    rhsToastTypeId: rhsToast.typeId
                )
				
                typeComparator.isEqual() ? equalAttributesCount += 1 : ()
			case .placement(let includingYOffset):
				let placementComparator = ToastPlacementComparator(
                    lhs: lhsToast.placement,
                    rhs: rhsToast.placement
				)
				
				if includingYOffset {
					placementComparator.isFullyEqauls() ? equalAttributesCount += 1 : ()
				} else {
					placementComparator.isEqualPlacementType() ? equalAttributesCount += 1 : ()
				}
			case .sourceView:
				let comparator = ToastSourceViewComparator(
                    lhs: lhsToast.sourceView,
					rhs: rhsToast.sourceView
				)
				
				comparator.isEquals() ? equalAttributesCount += 1 : ()
			}
		}
		
		return attributesCount == equalAttributesCount
	}
	
	func isOneOfAttributesEqual() -> Bool {
		for comparingAttribute in comparingAttributes {
			switch comparingAttribute {
			case .type:
                let typeComparator: ToastTypeComparator = ToastTypeComparator(
                    lhsToastTypeId: lhsToast.typeId,
                    rhsToastTypeId: rhsToast.typeId
                )
				
				if typeComparator.isEqual() {
					return true
				}
			case .placement(includingYOffset: let includingYOffset):
				let placementComparator: ToastPlacementComparator = ToastPlacementComparator(
                    lhs: lhsToast.placement,
                    rhs: rhsToast.placement
				)
				
				let isEqualPlacement: Bool = includingYOffset
				? placementComparator.isFullyEqauls()
				: placementComparator.isEqualPlacementType()
				
				if isEqualPlacement {
					return true
				}
			case .sourceView:
				let sourceComparator: ToastSourceViewComparator = ToastSourceViewComparator(
                    lhs: lhsToast.sourceView,
					rhs: rhsToast.sourceView
				)
				
				if sourceComparator.isEquals() {
					return true
				}
			}
		}
		
		return false
	}
}
