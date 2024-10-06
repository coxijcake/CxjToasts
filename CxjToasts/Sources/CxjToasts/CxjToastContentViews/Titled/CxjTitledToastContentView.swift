//
//  CxjTitledToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
public extension CxjTitledToastContentView {
    typealias Configuration = CxjTitledToastContentConfiguration
	typealias PlainLabelConfiguration = Configuration.TitlesParams.PlainLabel
	typealias AttributedLabelConfiguration = Configuration.TitlesParams.AttributedLabel
	typealias LabelParams = Configuration.TitlesParams.LabelParams
}

//MARK: - ContentView
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
	func configureWith(configuration: Configuration) {
		configureLayoutWith(layoutParams: configuration.layout)
		configureLabelsWith(titlesParams: configuration.titles)
    }
}

// MARK: - Main
private extension CxjTitledToastContentView {
	func configureLayoutWith(layoutParams: Configuration.LayoutParams) {
		spacing = layoutParams.labelsPadding
	}
	
	func configureLabelsWith(titlesParams: Configuration.TitlesParams) {
		switch titlesParams {
		case .plain(config: let config):
			configure(label: titleLabel, with: config.title)
			configure(label: subtitleLabel, with: config.subtitle)
		case .attributed(config: let config):
			configure(label: titleLabel, with: config.title)
			configure(label: subtitleLabel, with: config.subtitle)
		}
	}
	
	func configure(
		label: UILabel,
        with config: PlainLabelConfiguration?
	) {
		label.isHidden = (config == nil)
		guard let config = config else { return }
		
		label.text = config.text
		setup(params: config.labelParams, to: label)
	}
	
	func configure(
		label: UILabel,
		with attributedConfig: AttributedLabelConfiguration?
	) {
		label.isHidden = attributedConfig == nil
		guard let attributedConfig = attributedConfig else { return }
		
		label.attributedText = attributedConfig.text
		setup(params: attributedConfig.labelParams, to: label)
	}
	
	func setup(params: LabelParams, to label: UILabel) {
		label.numberOfLines = params.numberOfLines
		label.textAlignment = params.textAligment
	}
}

//MARK: - CxjToastContentView
extension CxjTitledToastContentView: CxjToastContentView {
    
}

// MARK: - Base Configuration
private extension CxjTitledToastContentView {
	func baseConfigure() {
		configureStackProps()
		addLabels()
	}
	
	func configureStackProps() {
		axis = .vertical
		distribution = .fillProportionally
		alignment = .fill
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
