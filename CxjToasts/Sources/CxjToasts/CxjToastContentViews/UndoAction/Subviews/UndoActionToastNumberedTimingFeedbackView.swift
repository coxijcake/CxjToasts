//
//  UndoActionToastNumberedTimingFeedbackView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/11/2024.
//

import UIKit

extension UndoActionToastNumberedTimingFeedbackView {
	struct ViewConfig {
		let numberColor: UIColor
		let numberFont: UIFont
	}
}

final class UndoActionToastNumberedTimingFeedbackView: UIView {
	//MARK: - Subviews
	private let label: UILabel = UILabel()
	
	//MARK: - Props
	private var lastUpdatedSecond: Int?
	
	//MARK: - Lifecycle
	init(config: ViewConfig, frame: CGRect = .zero) {
		super.init(frame: frame)
		
		baseConfigure()
		setupConfig(config)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		baseConfigure()
	}
}

//MARK: - Configuration
extension UndoActionToastNumberedTimingFeedbackView {
	func setupConfig(_ config: ViewConfig) {
		label.textColor = config.numberColor
		label.font = config.numberFont
	}
}

//MARK: - Base configuration
private extension UndoActionToastNumberedTimingFeedbackView {
	func baseConfigure() {
		addSubview(label)
		setupNumberLabel()
		setupLayout()
	}
	
	func setupLayout() {
		label.frame = bounds
		label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
	
	func setupNumberLabel() {
		label.textAlignment = .center
		label.minimumScaleFactor = 0.7
		label.adjustsFontSizeToFitWidth = true
	}
}

//MARK: - CxjToastTimingFeedbackView
extension UndoActionToastNumberedTimingFeedbackView: CxjToastTimingFeedbackView {
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {
		let roundedTime = time.rounded()
		let second = Int(roundedTime)
		
		guard lastUpdatedSecond != second else { return }
		
		lastUpdatedSecond = second
		label.text = "\(second)"
	}
	
	func updateForDismissingProgress(_ progress: Float, animated: Bool) {}
}
