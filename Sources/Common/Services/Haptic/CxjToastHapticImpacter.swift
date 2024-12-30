//
//  CxjToastHapticImpacter.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

@MainActor
enum CxjToastHapticImpacter {
    typealias Feedback = CxjHapticFeedback
    typealias Generator = CxjToastHapticFeedbackGenerator
    
    static func impactFeedback(_ feedback: Feedback) {
        let generator: Generator = CxjToastHapticFeedbackGeneratorFactory.generatorForFeedback(feedback)
        
        generator.prepare()
        generator.play()
    }
}
