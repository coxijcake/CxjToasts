//
//  CxjTitledToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTextContentView {
	enum Config {
		case singleTitle(label: UILabel)
		case withSubtitle(titleLabel: UILabel, subtitleLabel: UILabel, params: SubtitledConfigParams)
		
		struct SubtitledConfigParams {
			let labelsPadding: CGFloat
		}
	}
}

//MARK: - ContentView
final class CxjToastTextContentView: UIStackView {
	// MARK: - Lifecycle
	init(config: Config, frame: CGRect = .zero) {
		super.init(frame: frame)
		
		baseConfigure()
		setupConfiguration(config)
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
		
		baseConfigure()
	}
}

// MARK: - Main
private extension CxjToastTextContentView {
	func setupConfiguration(_ config: Config) {
		arrangedSubviews.forEach { removeArrangedSubview($0) }
		
		switch config {
		case .singleTitle(let label):
			addArrangedSubview(label)
		case .withSubtitle(let titleLabel, let subtitleLabel, let params):
			[titleLabel, subtitleLabel].forEach { addArrangedSubview($0) }
			spacing = params.labelsPadding
		}
	}
}

//MARK: - CxjToastContentView
extension CxjToastTextContentView: CxjToastContentView {
	public func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {}
	public func updateForDismissingProgress(_ progress: Float, animated: Bool) {}
}

// MARK: - Base Configuration
private extension CxjToastTextContentView {
	func baseConfigure() {
		configureStackProps()
	}
	
	func configureStackProps() {
		axis = .vertical
		distribution = .fill
		alignment = .fill
	}
}
