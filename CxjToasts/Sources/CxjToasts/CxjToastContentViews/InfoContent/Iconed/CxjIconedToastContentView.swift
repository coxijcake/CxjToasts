//
//  CxjIconedToastContentView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
public extension CxjIconedToastContentView {
	struct Config {
		struct Layout {
			enum IconPlacement {
				case left, top, right, bottom
			}
			
			let iconPlacement: IconPlacement
			let fromIconToInfoContentPadding: CGFloat
		}
		
		let iconImageView: UIImageView
		let infoContentView: UIView
		let layout: Layout
	}
}

//MARK: - ContentView
public final class CxjIconedToastContentView: UIStackView {
	// MARK: - Lifecycle
	init(config: Config, frame: CGRect) {
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
private extension CxjIconedToastContentView {
	func setupConfiguration(_ config: Config) {
		
		setupSubviewsForConfig(config)
		setupAxisForIconPlacement(config.layout.iconPlacement)
		
		spacing = config.layout.fromIconToInfoContentPadding
	}
	
	func setupSubviewsForConfig(_ config: Config) {
		arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		let orderedSubviews: [UIView]
		switch config.layout.iconPlacement {
		case .left, .top: orderedSubviews = [config.iconImageView, config.infoContentView]
		case .bottom, .right: orderedSubviews = [config.iconImageView, config.iconImageView]
		}
		
		orderedSubviews.forEach { addArrangedSubview($0) }
	}
	
	func setupAxisForIconPlacement(_ placement: Config.Layout.IconPlacement) {
		switch placement {
		case .left, .right: axis = .horizontal
		case .top, .bottom: axis = .vertical
		}
	}
}

//MARK: - CxjToastContentView
extension CxjIconedToastContentView: CxjToastContentView {
	public func updateForRemainingDisplayingTime(_ time: TimeInterval, animated: Bool) {}
	public func updateForDismissingProgress(_ progress: Float, animated: Bool) {}
}

// MARK: - Base Configuration
private extension CxjIconedToastContentView {
	func baseConfigure() {
		configureStackProps()
	}
	
	func configureStackProps() {
		distribution = .fill
		alignment = .center
	}
}
