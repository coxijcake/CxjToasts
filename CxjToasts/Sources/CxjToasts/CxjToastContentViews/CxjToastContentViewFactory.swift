//
//  CxjToastContentViewFactory.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
public enum CxjToastContentViewFactory {
    public static func createContentViewWith(config: CxjToastContentConfiguration) -> CxjToastContentView {
        switch config {
        case .iconed(config: let config, titlesConfig: let titlesConfig):
            let view: CxjIconedToastContentView = CxjIconedToastContentView()
            view.configureWith(config: config, titlesConfig: titlesConfig)
            
            return view
        case .titled(config: let config):
            let view: CxjTitledToastContentView = CxjTitledToastContentView()
            view.configureWith(configuration: config)
            
            return view
		case .titledAction(config: let config, titlesConfig: let titlesConfig):
			let titledView = CxjTitledToastContentView()
			titledView.configureWith(configuration: titlesConfig)
			
			let button: ToastActionButton = ToastActionButton()
			button.setupConfig(
				.init(
					title: .plain(
						text: "wdwqd",
						color: .white,
						font: .systemFont(ofSize: 15, weight: .semibold)
					)
				),
				forState: .normal
			)
			
			let view: CxjActionToastContentView = CxjActionToastContentView(
				contentView: titledView,
				actionControl: button,
				viewState: .init(
					layout: .init(
						controlPlacement: .right,
						paddingToContentView: 10
					)
				)
			)
			
			return view
		case .iconedAction(config: let config, iconConfig: let iconConfig, let titlesConfig):
			let iconedView: CxjIconedToastContentView = CxjIconedToastContentView()
			iconedView.configureWith(config: iconConfig, titlesConfig: titlesConfig)
			
			let control: UIControl
			switch config.actionControl {
			case .custom(let customControl):
				control = customControl
			case .default(let config, let actionCompletion):
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
				
				control = actionButton
			}
			
			let controlPlacement: CxjActionToastContentView.ViewState.Layout.ActionControlPlacement
			switch config.layout.actionControlPlacement {
			case .left: controlPlacement = .left
			case .top: controlPlacement = .top
			case .right: controlPlacement = .right
			case .bottom: controlPlacement = .bottom
			}
			
			let viewState: CxjActionToastContentView.ViewState = CxjActionToastContentView.ViewState(
				layout: .init(
					controlPlacement: controlPlacement,
					paddingToContentView: config.layout.paddingToInfoContent
				)
			)
			
			
			let view: CxjActionToastContentView = CxjActionToastContentView(
				contentView: iconedView,
				actionControl: control,
				viewState: viewState
			)
			
			return view
		case .undoAction(config: let config):
			return CxjUndoActionToastContentViewConfigurator.configuredContentViewWithConfig(config)
        case .custom(contentView: let contentView):
            return contentView
		}
    }
}
