//
//  CxjIconWithTextToastContentViewConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 10/12/2024.
//

import UIKit

@MainActor
enum CxjIconWithTextToastContentViewConfigurator {
	typealias Config = CxjIconedToastContentConfiguration
	typealias View = CxjIconedToastContentView
	
	static func viewWithConfig(_ config: Config, infoContentView: UIView) -> View {
		let imageView: UIImageView = iconImageViewWithParams(config.iconParams)
		let viewLayout: View.Config.Layout = viewLayoutWithLayoutParams(config.layout)
		
		let viewConfig: View.Config = View.Config(
			iconImageView: imageView,
			infoContentView: infoContentView,
			layout: viewLayout
		)
		
		let view: View = View(config: viewConfig, frame: .zero)
		
		return view
	}
	
	private static func iconImageViewWithParams(_ params: CxjIconConfiguration) -> UIImageView {
		let imageView: UIImageView = UIImageView(image: params.icon)
        imageView.contentMode = params.contentMode
		imageView.clipsToBounds = true
        
        if let cornerRadius: CGFloat = params.cornerRadius {
            imageView.layer.cornerRadius = cornerRadius
        }
		
		if let tintColor: UIColor = params.tintColor {
			imageView.tintColor = tintColor
		}
		
		if let fixedSize: CGSize = params.fixedSize {
			imageView.translatesAutoresizingMaskIntoConstraints = false
			imageView.widthAnchor.constraint(equalToConstant: fixedSize.width).isActive = true
			imageView.heightAnchor.constraint(equalToConstant: fixedSize.height).isActive = true
		}
		
		return imageView
	}
	
	private static func viewLayoutWithLayoutParams(_ params: Config.LayoutParams) -> View.Config.Layout {
		let iconPlacement: View.Config.Layout.IconPlacement
		switch params.iconPlacement {
		case .top: iconPlacement = .top
		case .bottom: iconPlacement = .bottom
		case .left: iconPlacement = .left
		case .right: iconPlacement = .right
		}
		
		let paddingToContent: CGFloat = params.paddingToContent
		
		return .init(
			iconPlacement: iconPlacement,
			fromIconToInfoContentPadding: paddingToContent
		)
	}
}
