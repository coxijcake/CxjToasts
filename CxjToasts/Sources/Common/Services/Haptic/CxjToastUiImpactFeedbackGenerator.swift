//
//  CxjToastUiImpactFeedbackGenerator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

@MainActor
final class CxjToastUiImpactFeedbackGenerator {
    typealias Generator = UIImpactFeedbackGenerator
    typealias Style = Generator.FeedbackStyle
    
    let uiImpactFeedbackGenerator: Generator
    
    init(style: Style) {
        uiImpactFeedbackGenerator = Generator(style: style)
    }
}

//MARK: - CxjToastHapticFeedbackGenerator
extension CxjToastUiImpactFeedbackGenerator: CxjToastHapticFeedbackGenerator {
    func prepare() {
        uiImpactFeedbackGenerator.prepare()
    }
    
    func play() {
        uiImpactFeedbackGenerator.impactOccurred()
    }
}
