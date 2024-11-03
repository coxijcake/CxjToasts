//
//  ToastTypeComparator.swift
//  
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import Foundation

struct ToastTypeComparator {
	typealias Toast = any CxjDisplayableToast
	
	let lhsToast: Toast
	let rhsToast: Toast
	
	func isEqual() -> Bool {
		lhsToast.typeId == rhsToast.typeId
	}
}
