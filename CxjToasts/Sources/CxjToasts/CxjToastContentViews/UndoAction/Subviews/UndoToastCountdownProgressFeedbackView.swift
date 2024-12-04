//
//  UndoToastCountdownProgressFeedbackView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 24/11/2024.
//

import UIKit

extension UndoToastCountdownProgressFeedbackView {
	struct ProgressState {
		let lineWidth: CGFloat
		let lineColor: UIColor
	}
}

final class UndoToastCountdownProgressFeedbackView: UIView {
	//MARK: - Subviews
	let circularProgressView: CircularCountdownProgressBarView
	
	//MARK: - Props
	let progressState: ProgressState
	
	//MARK: - Lifecyclce
	init(progressState: ProgressState, frame: CGRect = .zero) {
		self.progressState = progressState
		self.circularProgressView = CircularCountdownProgressBarView(
			appearance: .init(
				lineWidth: progressState.lineWidth,
				progressColor: progressState.lineColor
			)
		)
		
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Base configuration
private extension UndoToastCountdownProgressFeedbackView {
	func baseConfigure() {
		addSubview(circularProgressView)
		setupLayout()
	}
	
	func setupLayout() {
		circularProgressView.frame = bounds
		circularProgressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
	}
}

//MARK: - CxjToastTimingFeedbackView
extension UndoToastCountdownProgressFeedbackView: CxjToastTimingFeedbackView {
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {}
	
	func updateForDismissingProgress(_ progress: Float, animated: Bool) {
		circularProgressView.setProgress(CGFloat(progress), animated: animated)
	}
}

