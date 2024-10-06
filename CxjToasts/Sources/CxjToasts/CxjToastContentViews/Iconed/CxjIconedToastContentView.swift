//
//  CxjIconedToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
public extension CxjIconedToastContentView {
	typealias Configuration = CxjIconedToastContentConfiguration
    typealias IconParams = Configuration.IconParams
    typealias TitlesConfiguration = CxjTitledToastContentConfiguration
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
		configureWith(layoutParams: config.params)
        configureIconWith(iconParams: config.iconParams)
    }
	
	func configureWith(layoutParams: Configuration.LayoutParams) {
		setupSubviewsFor(iconPlacement: layoutParams.iconPlacement)
		setupAxisFor(iconPlacement: layoutParams.iconPlacement)
		
		spacing = layoutParams.paddingToTitle
	}
	
	func setupSubviewsFor(iconPlacement: Configuration.LayoutParams.IconPlacement) {
		arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		let orderedSubviews: [UIView]
		switch iconPlacement {
		case .left, .top: orderedSubviews = [iconImageView, titlesView]
		case .right, .bottom: orderedSubviews = [titlesView, iconImageView]
		}
		
		orderedSubviews.forEach { addArrangedSubview($0) }
	}
	
	func setupAxisFor(iconPlacement: Configuration.LayoutParams.IconPlacement) {
		switch iconPlacement {
		case .left, .right: axis = .horizontal
		case .top, .bottom: axis = .vertical
		}
	}
	
    func configureIconWith(
        iconParams: IconParams
    ) {
        iconImageView.image = iconParams.icon
        iconImageView.tintColor = iconParams.tintColor
		setupIconImageViewFixedSize(iconParams.fixedSize)
    }
}

// MARK: - Layout
private extension CxjIconedToastContentView {
	func setupIconImageViewFixedSize(_ size: CGSize?) {
		guard let size else { return }
		
		iconImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			iconImageView.widthAnchor.constraint(equalToConstant: size.width),
			iconImageView.heightAnchor.constraint(equalToConstant: size.height)
		])
	}
}

//MARK: - CxjToastContentView
extension CxjIconedToastContentView: CxjToastContentView {
    
}

// MARK: - Base Configuration
private extension CxjIconedToastContentView {
	func baseConfigure() {
		configureStackProps()
		addArrangedSubviews()
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
