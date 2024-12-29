//
//  CxjToastHapticFeedbackGenerator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 20/12/2024.
//

import UIKit

@MainActor
public protocol CxjToastHapticFeedbackGenerator: Sendable {
    func prepare()
    func play()
}
