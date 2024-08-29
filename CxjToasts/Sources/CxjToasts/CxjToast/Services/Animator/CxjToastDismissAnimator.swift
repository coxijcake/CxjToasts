//
//  CxjToastDismissAnimator.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

protocol CxjToastDismissAnimator {
	var dismissAnimation: CxjAnimation { get }
	func dismissAction(completion: BoolCompletion?)
}
