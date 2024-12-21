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
    
    struct ComparingValues {
        typealias Placement = CxjToastConfiguration.Layout.Placement
        
        let typeId: String
        let placement: Placement
        let sourceView: UIView
    }
}

struct ToastAttributesComparator {
	typealias ComparisonAttribute = CxjToastComparisonAttribute
	
	let lhsToastValues: ComparingValues
	let rhsToastValues: ComparingValues
	let comparingAttributes: Set<ComparisonAttribute>
	
	func isAllAttributesEqual() -> Bool {
		let attributesCount: Int = comparingAttributes.count
		var equalAttributesCount: Int = 0
		
		for comparingAttribute in comparingAttributes {
			switch comparingAttribute {
			case .type:
                let typeComparator: ToastTypeComparator = ToastTypeComparator(
                    lhsToastTypeId: lhsToastValues.typeId,
                    rhsToastTypeId: rhsToastValues.typeId
                )
				
                typeComparator.isEqual() ? equalAttributesCount += 1 : ()
			case .placement(let includingYOffset):
				let placementComparator = ToastPlacementComparator(
                    lhs: lhsToastValues.placement,
					rhs: rhsToastValues.placement
				)
				
				if includingYOffset {
					placementComparator.isFullyEqauls() ? equalAttributesCount += 1 : ()
				} else {
					placementComparator.isEqualPlacementType() ? equalAttributesCount += 1 : ()
				}
			case .sourceView:
				let comparator = ToastSourceViewComparator(
                    lhs: lhsToastValues.sourceView,
					rhs: rhsToastValues.sourceView
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
                    lhsToastTypeId: lhsToastValues.typeId,
                    rhsToastTypeId: rhsToastValues.typeId
                )
				
				if typeComparator.isEqual() {
					return true
				}
			case .placement(includingYOffset: let includingYOffset):
				let placementComparator: ToastPlacementComparator = ToastPlacementComparator(
                    lhs: lhsToastValues.placement,
                    rhs: rhsToastValues.placement
				)
				
				let isEqualPlacement: Bool = includingYOffset
				? placementComparator.isFullyEqauls()
				: placementComparator.isEqualPlacementType()
				
				if isEqualPlacement {
					return true
				}
			case .sourceView:
				let sourceComparator: ToastSourceViewComparator = ToastSourceViewComparator(
                    lhs: lhsToastValues.sourceView,
					rhs: rhsToastValues.sourceView
				)
				
				if sourceComparator.isEquals() {
					return true
				}
			}
		}
		
		return false
	}
}

enum ToastAttributesComparatorValuesConfigurator {
    static func valuesForToast(_ toast: any CxjDisplayableToast) -> ToastAttributesComparator.ComparingValues {
        .init(
            typeId: toast.typeId,
            placement: toast.config.layout.placement,
            sourceView: toast.config.sourceView
        )
    }
}
