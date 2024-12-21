//
//  ToastTypeComparator.swift
//  
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import Foundation

struct ToastTypeComparator {
    typealias ToastTypeId = String
	
	let lhsToastTypeId: ToastTypeId
	let rhsToastTypeId: ToastTypeId
	
	func isEqual() -> Bool {
        lhsToastTypeId == rhsToastTypeId
	}
}
