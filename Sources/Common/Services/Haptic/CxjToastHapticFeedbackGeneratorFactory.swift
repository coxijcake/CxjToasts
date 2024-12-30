//
//  CxjToastHapticFeedbackGeneratorFactory.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

@MainActor
enum CxjToastHapticFeedbackGeneratorFactory {
    typealias Feedback = CxjHapticFeedback
    
    static func generatorForFeedback(_ feedback: Feedback) -> CxjToastHapticFeedbackGenerator {
        switch feedback {
        case .uiImpact(style: let style):
            return CxjToastUiImpactFeedbackGenerator(style: style)
        case .notification(type: let type):
            return CxjToastNotificationFeebackGenerator(feedbackType: type)
        case .custom(generator: let generator):
            return generator
        }
    }
}

