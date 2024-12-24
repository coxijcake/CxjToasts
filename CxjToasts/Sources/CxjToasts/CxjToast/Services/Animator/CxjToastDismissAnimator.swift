//
//  CxjToastDismissAnimator.swift
//  
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

@MainActor
protocol CxjToastDismissAnimator {
	var dismissAnimation: CxjAnimation { get }
    var dismissedStateTranslation: CGPoint { get }
    
	func dismissAction(progress: CGFloat, animated: Bool, completion: CxjBoolCompletion?)
}
