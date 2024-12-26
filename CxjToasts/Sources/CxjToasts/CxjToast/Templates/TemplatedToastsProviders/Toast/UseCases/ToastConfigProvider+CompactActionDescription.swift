//
//  ToastConfigProvider+CompactActionDescription.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 19/12/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
    final class CompactActionDescriptionConfigProvider: CxjTemplatedToastConfigProvider {
        typealias Data = CxjToastTemplate.CompactActionDescriptionToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func config() -> Config {
            let sourceView: UIView = data.customSourceView ?? defaultSourceView()
            
            return .init(
                typeId: data.typeId,
                sourceView: sourceView,
                sourceBackground: nil,
                layout: layoutInsideView(sourceView),
                dismissMethods: dismissMethods(),
                keyboardHandling: .ignore,
                animations: animations(),
				hapticFeeback: data.hapticFeeback,
                spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
            )
        }
        
        private func layoutInsideView(_ sourceView: UIView) -> Config.Layout {
            .init(
                constraints: constraintsInsideView(sourceView),
                placement: placement()
            )
        }
        
        private func constraintsInsideView(_ sourceView: UIView) -> Config.Constraints {
            Config.Constraints(
                width: widthConstraintsInsideView(sourceView),
                height: heightConstraint()
            )
        }
        
        private func widthConstraintsInsideView(_ sourceView: UIView) -> Config.Constraints.Values {
            return .init(
                min: 60,
                max: sourceView.bounds.size.width * 0.8
            )
        }
        
        private func heightConstraint() -> Config.Constraints.Values {
            .init(
                min: 42,
                max: 52
            )
        }
        
        private func placement() -> Config.Layout.Placement {
            .center
        }
        
        private func dismissMethods() -> Set<Config.DismissMethod> {
            [
                .tap(actionCompletion: nil),
                .automatic(time: 2.0)
            ]
        }
        
        private func animations() -> Config.Animations {
            let behaviour: Config.Animation.Behaviour = .custom(changes: [
				.alpha(intensity: .zero),
                .scale(value: .init(x: 0.25, y: 0.25))
            ])
            
            let present: Config.Animation = .init(
                animation: .toastPresenting,
                behaviour: behaviour
            )
            
            let dismiss: Config.Animation = .init(
                animation: .toastDismissing,
                behaviour: behaviour
            )
            
            return Config.Animations(
                present: present,
                dismiss: dismiss
            )
        }
        
        private func spamProtection() -> Config.SpamProtection {
            .on(
                comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
            )
        }
        
        private func coexistencePolicy() -> Config.ToastCoexistencePolicy {
            .init(
                handling: .dismiss,
                comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
            )
        }
    }
}

//MARK: - CxjAnimation extensions
fileprivate extension CxjAnimation {
    static let toastPresenting = CxjAnimation { (animations, completion) in
        UIView.animate(
            withDuration: 1.0,
            delay: .zero,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 15.0,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
    
    static let toastDismissing = CxjAnimation { (animations, completion) in
        UIView.animate(
            withDuration: 0.175,
            delay: .zero,
			options: [.curveEaseIn, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
}
