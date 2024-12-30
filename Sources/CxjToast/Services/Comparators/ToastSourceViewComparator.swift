//
//  ToastSourceViewComparator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/11/2024.
//

import UIKit

struct ToastSourceViewComparator {
	typealias SourceView = UIView
	
	let lhs: SourceView
	let rhs: SourceView
	
	func isEquals() -> Bool {
		lhs === rhs
	}
}
