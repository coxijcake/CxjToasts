//
//  CxjHapticFeedback.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

public enum CxjHapticFeedback: Sendable {
    case uiImpact(style: UIImpactFeedbackGenerator.FeedbackStyle)
    case notification(type: UINotificationFeedbackGenerator.FeedbackType)
    case custom(generator: CxjToastHapticFeedbackGenerator)
}
