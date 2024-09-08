//
//  CxjToastTheme.swift
//
//
//  Created by Nikita Begletskiy on 07/09/2024.
//

import UIKit

//MARK: - Types
extension CxjToastTheme {
	public typealias ViewConfig = CxjToastViewConfiguration
	typealias ViewConfigurator = CxjToastViewConfigurator
	
	public typealias ToastConfig = CxjToastConfiguration
}

public enum CxjToastTheme {
	case native
}

//MARK: - ToastViewConfiguration
extension CxjToastTheme {
	public var toastViewConfig: ViewConfig {
		ViewConfigurator.config(for: self)
	}
	
	public var viewContentInsets: UIEdgeInsets {
		ViewConfigurator.contentInsets(for: self)
	}
	
	public var viewColors: ViewConfig.Colors {
		ViewConfigurator.colors(for: self)
	}
	
	public var viewShadow: ViewConfig.Shadow {
		ViewConfigurator.shadow(for: self)
	}
	
	public var viewCornerRadius: CGFloat {
		ViewConfigurator.cornerRadius(for: self)
	}
}

//MARK: - ToastConfig
extension CxjToastTheme {
	public var toastConfig: ToastConfig {
		ToastConfig(
			sourceView: sourceView,
			layout: layout,
			dismissMethods: dismissMethods,
			animations: animations
		)
	}
	
	public var sourceView: UIView {
		switch self {
		case .native:
			UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
		}
	}
	
	public var layout: ToastConfig.Layout {
		ToastConfig.Layout(
			constraints: CxjToastConfiguration.Constraints(
				width: widthConstraint,
				height: heightConstraint
			),
			placement: placement
		)
	}
	
	public var widthConstraint: ToastConfig.Constraints.Values {
		switch self {
		case .native:
			CxjToastConfiguration.Constraints.Values(
				min: sourceView.bounds.size.width * 0.65,
				max: sourceView.bounds.size.width - 16 * 2
			)
		}
	}
	
	public var heightConstraint: ToastConfig.Constraints.Values {
		switch self {
		case .native:
			CxjToastConfiguration.Constraints.Values(
				min: 40,
				max: 70
			)
		}
	}
	
	public var placement: ToastConfig.Layout.Placement {
		switch self {
		case .native: .top(verticalOffset: 20)
		}
	}
	
	public var dismissMethods: Set<ToastConfig.DismissMethod> {
		switch self {
		case .native:
			[
				.automatic(time: 3.0),
				.tap,
				.swipe(direction: .top)
			]
		}
	}
	
	public var animations: ToastConfig.Animations {
		ToastConfig.Animations(
			present: presentAnimation,
			dismiss: dismissAnimation
		)
	}
	
	public var presentAnimation: CxjAnimation {
		switch self {
		case .native: .nativeToastPresenting
		}
	}
	
	public var dismissAnimation: CxjAnimation {
		switch self {
		case .native: .nativeToastDismissing
		}
	}
}


enum CxjToastViewConfigurator {
	typealias Theme = CxjToastTheme
	typealias Config = CxjToastViewConfiguration
	
	static func config(for theme: Theme) -> Config {
		Config(
			contentInsets: contentInsets(for: theme),
			colors: colors(for: theme),
			shadow: shadow(for: theme),
			cornerRadius: cornerRadius(for: theme)
		)
	}
	
	static func contentInsets(for theme: Theme) -> UIEdgeInsets {
		switch theme {
		case .native:
			UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
		}
	}
	
	static func colors(for theme: Theme) -> Config.Colors {
		switch theme {
		case .native: Config.Colors(background: .white)
		}
	}
	
	static func shadow(for theme: Theme) -> Config.Shadow {
		switch theme {
		case .native:
				.enable(params: CxjToastViewConfiguration.Shadow.Params(
					offset: CGSize(width: 0, height: 4),
					color: .black.withAlphaComponent(0.28),
					opacity: 1.0,
					radius: 10
				)
				)
		}
	}
	
	static func cornerRadius(for theme: Theme) -> CGFloat {
		switch theme {
		case .native: 10.0
		}
	}
}


fileprivate extension CxjAnimation {
	static let nativeToastPresenting = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 1.0,
			delay: .zero,
			usingSpringWithDamping: 0.65,
			initialSpringVelocity: 10.0,
			options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState],
			animations: animations,
			completion: completion
		)
	}
	
	static let nativeToastDismissing = CxjAnimation { (animations, completion) in
		UIView.animate(
			withDuration: 0.25,
			delay: .zero,
			options: [.curveEaseIn, .beginFromCurrentState],
			animations: animations,
			completion: completion
		)
	}
}
