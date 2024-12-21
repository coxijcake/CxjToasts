//
//  CxjToastNotificationFeebackGenerator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

@MainActor
final class CxjToastNotificationFeebackGenerator {
    typealias Generator = UINotificationFeedbackGenerator
    typealias FeedbackType = Generator.FeedbackType
     
    let uiNotificationFeebackGenerator: Generator = Generator()
    
    let feedbackType: FeedbackType
    
    init(feedbackType: FeedbackType) {
        self.feedbackType = feedbackType
    }
}

extension CxjToastNotificationFeebackGenerator: CxjToastHapticFeedbackGenerator {
    func prepare() {
        uiNotificationFeebackGenerator.prepare()
    }
    
    func play() {
        uiNotificationFeebackGenerator.notificationOccurred(feedbackType)
    }
}
