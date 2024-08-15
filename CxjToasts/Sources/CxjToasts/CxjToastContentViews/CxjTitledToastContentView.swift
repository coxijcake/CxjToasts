//
//  CxjTitledToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

public final class CxjTitledToastContentView: UIStackView {
	// MARK: - Subviews
	private lazy var titleLabel: UILabel = createTitleLabel()
	private lazy var subtitleLabel: UILabel = createSubtitleLabel()
	
	// MARK: - Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		baseConfigure()
	}
	
	required init(coder: NSCoder) {
		super.init(coder: coder)
		
		baseConfigure()
	}
}

// MARK: - Public
public extension CxjTitledToastContentView {
	func configureWith(
		configuration: TitledToastConfiguration
	) {
		configure(label: titleLabel, with: configuration.title)
		configure(label: subtitleLabel, with: configuration.subtitle)
	}
	
	func configureWith(
		attributedConfiguration: TitledToastAttributedConfiguration
	) {
		configure(label: titleLabel, with: attributedConfiguration.title)
		configure(label: subtitleLabel, with: attributedConfiguration.subtitle)
	}
}

// MARK: - Main
private extension CxjTitledToastContentView {
	func configure(
		label: UILabel,
		with config: ToastLabelConfiguration?
	) {
		label.isHidden = (config == nil)
		guard let config = config else { return }
		
		label.text = config.text
		setup(params: config.labelParams, to: label)
	}
	
	func configure(
		label: UILabel,
		with attributedConfig: ToastAttributedLabelConfiguration?
	) {
		label.isHidden = attributedConfig == nil
		guard let attributedConfig = attributedConfig else { return }
		
		label.attributedText = attributedConfig.text
		setup(params: attributedConfig.labelParams, to: label)
	}
	
	func setup(params: ToastLabelParams, to label: UILabel) {
		label.numberOfLines = params.numberOfLines
	}
}

// MARK: - Base Configuration
private extension CxjTitledToastContentView {
	func baseConfigure() {
		configureStackProps()
		addLabels()
	}
	
	func configureStackProps() {
		axis = .vertical
		distribution = .fillEqually
		alignment = .center
		spacing = 2
	}
	
	func addLabels() {
		[titleLabel, subtitleLabel].forEach { addArrangedSubview($0) }
	}
}

// MARK: - Subviews Creation
private extension CxjTitledToastContentView {
	func createTitleLabel() -> UILabel {
		let label: UILabel = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
		label.textColor = .black
		
		return label
	}
	
	func createSubtitleLabel() -> UILabel {
		let label: UILabel = UILabel()
		label.numberOfLines = 1
		label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
		label.textColor = .black.withAlphaComponent(0.8)
		
		return label
	}
}
