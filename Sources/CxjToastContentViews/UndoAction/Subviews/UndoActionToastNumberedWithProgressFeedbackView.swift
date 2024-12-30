//
//  UndoActionToastNumberedWithProgressFeedbackView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 25/11/2024.
//

import UIKit

final class UndoActionToastNumberedWithProgressFeedbackView: UIView {
	//MARK: - Subviews
	let timingFeebackView: CxjToastTimingFeedbackView
	let progressFeedbackView: CxjToastTimingFeedbackView
	
	//MARK: - Lifecycle
	init(
		timingFeebackView: CxjToastTimingFeedbackView,
		progressFeedbackView: CxjToastTimingFeedbackView,
		frame: CGRect = .zero
	) {
		self.timingFeebackView = timingFeebackView
		self.progressFeedbackView = progressFeedbackView
		
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		[timingFeebackView, progressFeedbackView]
			.forEach { $0.frame = bounds }
	}
}

//MARK: - CxjToastTimingFeedbackView
extension UndoActionToastNumberedWithProgressFeedbackView: CxjToastTimingFeedbackView {
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {
		timingFeebackView.updateForRemainingDisplayingTime(time, animated: animated)
	}
	
	func updateForDismissingProgress(_ progress: Float, animated: Bool) {
		progressFeedbackView.updateForDismissingProgress(progress, animated: animated)
	}
}

//MARK: - Base configuration
private extension UndoActionToastNumberedWithProgressFeedbackView {
	func baseConfigure() {
		[progressFeedbackView, timingFeebackView].forEach { addSubview($0) }
	}
}
