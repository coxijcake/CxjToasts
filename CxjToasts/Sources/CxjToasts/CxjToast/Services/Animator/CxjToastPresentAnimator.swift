//
//  CxjToastPresentAnimator.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

@MainActor
protocol CxjToastPresentAnimator {
    var presentAnimation: CxjAnimation { get }
	
	func presentAction(animated: Bool, completion: CxjBoolCompletion?)
}
