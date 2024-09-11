//
//  CxjToastView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastContainerView {
    
}

final class CxjToastContainerView: UIView {
    //MARK: - Subviews
    private let contentView: CxjToastContentView
    //MARK: - Props
    private let config: CxjToastViewConfiguration
	
    //MARK: - Lifecycle
	public init(
		config: CxjToastViewConfiguration,
		contentView: CxjToastContentView
	) {
		self.config = config
		self.contentView = contentView
        
        super.init(frame: .zero)
        
        baseConfigure()
        configureUI(with: config)
	}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - CxjToastView
extension CxjToastContainerView: CxjToastView {
    func prepareToDisplay() {
        configureShadow(with: config.shadow)
        configureCornes(with: config.corners)
    }
}

//MARK: - Configuration
private extension CxjToastContainerView {
    func configureUI(with config: Configuration) {
        configureContentLayout(with: config.contentInsets)
        configureColors(with: config.colors)
        configureShadow(with: config.shadow)
        configureCornes(with: config.corners)
    }
    
    func configureContentLayout(with insets: UIEdgeInsets) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }
    
    func configureColors(with config: Configuration.Colors) {
        backgroundColor = config.background
    }
    
    func configureShadow(with config: Configuration.Shadow) {
        switch config {
        case .enable(params: let params):
            layer.masksToBounds = false
            layer.shadowOffset = params.offset
            layer.shadowColor = params.color.cgColor
            layer.shadowOpacity = params.opacity
            layer.shadowRadius = params.radius
        case .disable:
            return
        }
    }
	
	func configureCornes(with corners: Configuration.Corners) {
		switch corners {
		case .straight: break
		case .capsule: layer.cornerRadius = bounds.size.height * 0.5
		case .rounded(value: let value): layer.cornerRadius = value
		}
	}
}

//MARK: - Base Configuration
private extension CxjToastContainerView {
    func baseConfigure() {
		clipsToBounds = true
		
        addSubview(contentView)
    }
}
