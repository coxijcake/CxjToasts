//
//  CxjToastViewConfigurator.swift
//  
//
//  Created by Nikita Begletskiy on 08/09/2024.
//

import UIKit

enum CxjToastViewConfigurator {
    typealias Theme = CxjToastTheme
    typealias Config = CxjToastViewConfiguration
    
    static func config(for theme: Theme) -> Config {
        Config(
            contentInsets: contentInsets(for: theme),
            colors: colors(for: theme),
            shadow: shadow(for: theme),
            corners: corners(for: theme)
        )
    }
    
    static func contentInsets(for theme: Theme) -> UIEdgeInsets {
        switch theme {
        case .native:
            UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        }
    }
    
    static func colors(for theme: Theme) -> Config.Colors {
        switch theme {
		case .native(data: let data): .init(background: data.backgroundColor)
        }
    }
    
	static func shadow(for theme: Theme) -> Config.Shadow {
		switch theme {
		case .native:
				.enable(params: CxjToastViewConfiguration.Shadow.Params(
					offset: CGSize(width: 0, height: 4),
					color: .black.withAlphaComponent(0.4),
					opacity: 1.0,
					radius: 10
				)
				)
		}
	}
    
	static func corners(for theme: Theme) -> Config.Corners {
		switch theme {
		case .native: .capsule(mask: .all)
		}
    }
}
