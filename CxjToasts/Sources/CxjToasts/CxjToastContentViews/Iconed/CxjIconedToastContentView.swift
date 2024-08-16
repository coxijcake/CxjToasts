//
//  CxjIconedToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
public extension CxjIconedToastContentView {
	typealias Configuration = CxjIconedToastConfiguration
    typealias IconParams = Configuration.IconParams
    typealias TitlesConfiguration = CxjToastTitlesConfiguration
}

extension CxjIconedToastContentView {
	enum Constants {
		enum Layout {
			static let iconSize: CGSize = CGSize(width: 28, height: 28)
		}
	}
}

//MARK: - ContentView
public final class CxjIconedToastContentView: UIStackView {
	// MARK: - Subviews
	private lazy var titlesView: CxjTitledToastContentView = createTitlesView()
	private lazy var iconImageView: UIImageView = createIconImageView()
	
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
public extension CxjIconedToastContentView {
    func configureWith(
        config: Configuration,
        titlesConfig: TitlesConfiguration
    ) {
        configureWith(config: config)
        titlesView.configureWith(configuration: titlesConfig)
    }
}

// MARK: - Main
private extension CxjIconedToastContentView {
    func configureWith(
        config: Configuration
    ) {
        configureIconWith(iconParams: config.params)
    }
    
    func configureIconWith(
        iconParams: IconParams
    ) {
        iconImageView.image = iconParams.icon
        iconImageView.tintColor = iconParams.tintColor
    }
}

// MARK: - Layout
private extension CxjIconedToastContentView {
	func setupConstraints() {
		setupIconImageViewConstraints()
	}
	
	func setupIconImageViewConstraints() {
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			iconImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.iconSize.width),
			iconImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.iconSize.height)
		])
	}
}

// MARK: - Base Configuration
private extension CxjIconedToastContentView {
	func baseConfigure() {
		configureStackProps()
		addArrangedSubviews()
		setupConstraints()
	}
	
	func configureStackProps() {
		axis = .horizontal
		distribution = .fill
		alignment = .center
		spacing = 16
	}
	
	func addArrangedSubviews() {
		[iconImageView, titlesView].forEach { addArrangedSubview($0) }
	}
}

// MARK: - Subviews Creation
private extension CxjIconedToastContentView {
	func createTitlesView() -> CxjTitledToastContentView {
		let view: CxjTitledToastContentView = CxjTitledToastContentView()
		
		return view
	}
	
	func createIconImageView() -> UIImageView {
		let imageView: UIImageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}
}
