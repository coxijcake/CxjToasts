//
//  ToastAttributesComparator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/11/2024.
//

import Foundation

struct ToastAttributesComparator {
	typealias Attribute = CxjToastConfiguration.ToastComparingAttribute
	typealias Toast = (any CxjDisplayableToast)
	
	let lhsToast: Toast
	let rhsToast: Toast
	let comparingAttributes: Set<Attribute>
	
	func isEqual() -> Bool {
		var equalAttributesCount: Int = 0
		
		for comparingAttribute in comparingAttributes {
			switch comparingAttribute {
			case .type:
				let comparator: ToastTypeComparator = ToastTypeComparator(
					lhsToast: lhsToast,
					rhsToast: rhsToast
				)
				
				comparator.isEqual() ? equalAttributesCount += 1 : ()
			case .placement(let includingYOffset):
				let placementComparator = ToastPlacementComparator(
					lhs: lhsToast.config.layout.placement,
					rhs: rhsToast.config.layout.placement
				)
				
				if includingYOffset {
					placementComparator.isFullyEqauls() ? equalAttributesCount += 1 : ()
				} else {
					placementComparator.isEqualPlacementType() ? equalAttributesCount += 1 : ()
				}
			case .sourceView:
				let comparator = ToastSourceViewComparator(
					lhs: lhsToast.config.sourceView,
					rhs: rhsToast.config.sourceView
				)
				
				comparator.isEquals() ? equalAttributesCount += 1 : ()
			}
		}
		
		return comparingAttributes.count == equalAttributesCount
	}
}
