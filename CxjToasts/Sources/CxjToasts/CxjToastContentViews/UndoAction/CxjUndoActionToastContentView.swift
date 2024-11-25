//
//  CxjUndoActionToastContentView.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

public protocol CxjToastTimingFeedbackView: UIView {
	func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool)
	func updateForDismissingProgress(_ progress: Float, animated: Bool)
}

//MARK: - ContentView
public final class CxjUndoActionToastContentView: UIStackView {
	//MARK: - Subviews
	private let leadingStackView: UIStackView = UIStackView()
	
	private let timingFeedbackView: CxjToastTimingFeedbackView?
	private let infoContentView: UIView
	private let undoButton: UIControl
	
	//MARK: - Lifecycle
	public init(
		timingFeedbackView: CxjToastTimingFeedbackView?,
		infoContentView: UIView,
		undoButton: UIControl,
		frame: CGRect = .zero
	) {
		self.timingFeedbackView = timingFeedbackView
		self.infoContentView = infoContentView
		self.undoButton = undoButton
		
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - CxjToastContentView
extension CxjUndoActionToastContentView: CxjToastContentView {
	public func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {
		timingFeedbackView?.updateForRemainingDisplayingTime(time, animated: animated)
	}
	
	public func updateForDismissingProgress(_ progress: Float, animated: Bool) {
		timingFeedbackView?.updateForDismissingProgress(progress, animated: animated)
	}
}

//MARK: - Base configuration
private extension CxjUndoActionToastContentView {
	func baseConfigure() {
		axis = .horizontal
		distribution = .equalSpacing
		alignment = .center
		spacing = 10
		
		setupSubviews()
	}
	
	func setupSubviews() {
		if let timingFeedbackView {
			NSLayoutConstraint.activate([
				timingFeedbackView.widthAnchor.constraint(equalToConstant: 30),
				timingFeedbackView.heightAnchor.constraint(equalToConstant: 30)
			])
		}
		
		[leadingStackView, undoButton]
			.forEach { addArrangedSubview($0) }
		[timingFeedbackView, infoContentView]
			.withoutOptionals()
			.forEach { leadingStackView.addArrangedSubview($0) }
		
		configureLeadingStrackView()
	}
	
	func configureLeadingStrackView() {
		leadingStackView.axis = .horizontal
		leadingStackView.distribution = .fillProportionally
		leadingStackView.alignment = .center
		leadingStackView.spacing = 10
	}
}
