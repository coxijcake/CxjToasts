//
//  CxjActionToastContentViewConfigurator.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 10/12/2024.
//

import UIKit

@MainActor
enum CxjActionToastContentViewConfigurator {
	typealias Config = CxjActionToastContentConfiguration
	typealias View = CxjActionToastContentView
	
	static func createViewWithConfig(_ config: Config, infoContentView: UIView) -> View {
		let actionControl: UIControl = actionControlForConfig(config.actionControl)
		let viewConfig: View.Config = viewConfigForConfig(config)
		
		let view: View = View(contentView: infoContentView, actionControl: actionControl, viewConfig: viewConfig)
		
		return view
	}
	
	private static func viewConfigForConfig(_ config: Config) -> View.Config {
		let controlPlacement: View.Config.Layout.ActionControlPlacement
		switch config.layout.actionControlPlacement {
		case .top: controlPlacement = .top
		case .bottom: controlPlacement = .bottom
		case .left: controlPlacement = .left
		case .right: controlPlacement = .right
		}
		
		let viewConfig: View.Config = .init(
			layout: .init(
				controlPlacement: controlPlacement,
				paddingToContentView: config.layout.paddingToInfoContent
			)
		)
		
		return viewConfig
	}
	
	private static func actionControlForConfig(_ config: Config.ActionControl) -> UIControl {
		switch config {
		case .custom(control: let control, let actionCompletion):
			let resultControl = control
			if let actionCompletion {
				resultControl.addAction(
					.init(handler: { _ in actionCompletion()}),
					for: .touchUpInside
				)
			}
			
			return resultControl
		case .default(config: let config, actionCompletion: let actionCompletion):
			let actionButton: ToastActionButton = ToastActionButton()
			switch config {
			case .plain(config: let config):
				actionButton.setupConfig(
					.init(
						title: .plain(
							text: config.text,
							color: config.textColor,
							font: config.font
						)
					),
					forState: .normal
				)
			case .attributed(string: let string):
				actionButton.setupConfig(
					.init(title: .attributed(text: string)),
					forState: .normal
				)
			}
			
			if let actionCompletion {
				actionButton.addAction(
					.init(handler: { _ in actionCompletion()}),
					for: .touchUpInside
				)
			}
			
			return actionButton
		}
	}
}
