//
//  CxjToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public protocol CxjToastContentView: UIView {
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool)
	func updateForDismissingProgress(_ progress: Float, animated: Bool)
}
