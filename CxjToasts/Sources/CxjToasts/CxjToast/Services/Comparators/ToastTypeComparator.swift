//
//  ToastTypeComparator.swift
//  
//
//  Created by Nikita Begletskiy on 03/11/2024.
//

import Foundation

struct ToastTypeComparator {
	let lhsToastTypeId: CxjToastTypeid
	let rhsToastTypeId: CxjToastTypeid
	
	func isEqual() -> Bool {
        lhsToastTypeId == rhsToastTypeId
	}
}
