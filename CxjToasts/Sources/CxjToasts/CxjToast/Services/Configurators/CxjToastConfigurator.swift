//
//  CxjToastConfigurator.swift
//  
//
//  Created by Nikita Begletskiy on 08/09/2024.
//

import UIKit

enum CxjToastConfigurator {
    typealias Theme = CxjToastTheme
    typealias Config = CxjToastConfiguration
    
    static func config(for theme: Theme) -> Config {
        Config(
            sourceView: sourceView(for: theme),
            layout: layout(for: theme),
            dismissMethods: dismissMethods(for: theme),
            animations: animations(for: theme)
        )
    }
    
    static func sourceView(for theme: Theme) -> UIView {
        switch theme {
        case .native:
            UIApplication.keyWindow
            ?? UIApplication.topViewController()?.view
            ?? UIView()
        }
    }
    
    static func layout(for theme: Theme) -> Config.Layout {
        Config.Layout(
            constraints: constraints(for: theme),
            placement: placement(for: theme)
        )
    }
    
    static func constraints(for theme: Theme) -> Config.Constraints {
        Config.Constraints(
            width: widthConstraint(for: theme),
            height: heightConstraint(for: theme)
        )
    }
    
    static func widthConstraint(for theme: Theme) -> Config.Constraints.Values {
        let sourceView: UIView = sourceView(for: theme)
        
        return switch theme {
        case .native:
            Config.Constraints.Values(
                min: sourceView.bounds.size.width * 0.5,
                max: sourceView.bounds.size.width - 16 * 2
            )
        }
    }
    
    static func heightConstraint(for theme: Theme) -> Config.Constraints.Values {
        switch theme {
        case .native:
            Config.Constraints.Values(
//                min: 140,
//                max: 140
                min: 50,
                max: 70
            )
        }
    }
    
    static func placement(for theme: Theme) -> Config.Layout.Placement {
        switch theme {
        case .native: .top(verticalOffset: 20)
        }
    }
    
    static func dismissMethods(for theme: Theme) -> Set<Config.DismissMethod> {
        switch theme {
        case .native:
            [
                .automatic(time: 2.0),
                .swipe(direction: .top)
            ]
        }
    }
    
    static func animations(for theme: Theme) -> Config.Animations {
        Config.Animations(
            present: presentAnimation(for: theme),
            dismiss: dismissAnimation(for: theme),
			behaviour: .default,
            nativeViewsIncluding: [.dynamicIsland, .notch]
        )
    }
    
    static func presentAnimation(for theme: Theme) -> CxjAnimation {
//        return .testSlow
        switch theme {
        case .native: .nativeToastPresenting
        }
    }
    
    static func dismissAnimation(for theme: Theme) -> CxjAnimation {
//        return .testSlow
        switch theme {
        case .native: .nativeToastDismissing
        }
    }
}
