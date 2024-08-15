//
//  CxjToastView.swift
//
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit

//MARK: - Types
extension CxjToastView {
    typealias Configuration = CxjToastViewConfiguration
    typealias ShadowConfiguration = Configuration.Shadow
    typealias ColorsConfiguration = Configuration.Colors
}


public final class CxjToastView: UIView {
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

//MARK: - Configuration
private extension CxjToastView {
    func configureUI(with config: Configuration) {
        configureContentLayout(with: config.contentInsets)
        configureColors(with: config.colors)
        configureShadow(with: config.shadow)
        
        clipsToBounds = true
        layer.cornerRadius = config.cornerRadius
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
    
    func configureColors(with config: ColorsConfiguration) {
        backgroundColor = config.background
    }
    
    func configureShadow(with config: ShadowConfiguration) {
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
}

//MARK: - Base Configuration
private extension CxjToastView {
    func baseConfigure() {
        addSubview(contentView)
    }
}
