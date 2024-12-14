//
//  ToastAttributesComparator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/11/2024.
//

import Foundation

extension ToastAttributesComparator {
	enum ValidationResult {
		case passed
		case failed
	}
}

struct ToastAttributesComparator {
	typealias Attribute = CxjToastComparisonAttribute
	typealias Toast = (any CxjDisplayableToast)
	
	let lhsToast: Toast
	let rhsToast: Toast
	let comparingAttributes: Set<Attribute>
	
	func isAllAttributesEqual() -> Bool {
		let attributesCount: Int = comparingAttributes.count
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
		
		return attributesCount == equalAttributesCount
	}
	
	func isOneOfAttributesEqual() -> Bool {
		for comparingAttribute in comparingAttributes {
			switch comparingAttribute {
			case .type:
				let typeComparator: ToastTypeComparator = ToastTypeComparator(
					lhsToast: lhsToast,
					rhsToast: rhsToast
				)
				
				if typeComparator.isEqual() {
					return true
				}
			case .placement(includingYOffset: let includingYOffset):
				let placementComparator: ToastPlacementComparator = ToastPlacementComparator(
					lhs: lhsToast.config.layout.placement,
					rhs: rhsToast.config.layout.placement
				)
				
				let isEqualPlacement: Bool = includingYOffset
				? placementComparator.isFullyEqauls()
				: placementComparator.isEqualPlacementType()
				
				if isEqualPlacement {
					return true
				}
			case .sourceView:
				let sourceComparator: ToastSourceViewComparator = ToastSourceViewComparator(
					lhs: lhsToast.config.sourceView,
					rhs: rhsToast.config.sourceView
				)
				
				if sourceComparator.isEquals() {
					return true
				}
			}
		}
		
		return false
	}
}
