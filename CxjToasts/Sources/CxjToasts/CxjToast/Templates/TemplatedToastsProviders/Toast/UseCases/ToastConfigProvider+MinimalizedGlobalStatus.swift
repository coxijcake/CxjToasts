//
//  ToastConfigProvider+MinimalizedGlobalStatus.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 17/12/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
    final class MinimaliedGlobalStatusToastConfigProvider: CxjTemplatedToastConfigProvider {
        typealias Data = CxjToastTemplate.MinimaliedGlobalStatusToastData
        
        let data: Data
        
        init(data: Data) {
            self.data = data
        }
        
        func config() -> Config {
            let soureView: UIView = defaultSourceView()
            
            return .init(
                typeId: data.typeId,
                sourceView: soureView,
                sourceBackground: sourceBackground(),
                layout: layoutInsideView(soureView),
                dismissMethods: data.dismissMethods,
                keyboardHandling: .ignore,
                animations: animations(),
                spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
            )
        }
        
        private func sourceBackground() -> Config.SourceBackground? {
            nil
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
            let width: CGFloat = sourceView.bounds.size.width
            
            return .init(min: width, max: width)
        }
        
        private func heightConstraint() -> Config.Constraints.Values {
            let topSafeAreaHeight: CGFloat = UIApplication.safeAreaInsets.top
            
            let height: CGFloat = (topSafeAreaHeight > 20)
            ? 75
            : 55
            
            return .init(min: height, max: height)
        }
        
        private func placement() -> Config.Layout.Placement {
            .top(params: .init(offset: .zero, includingSafeArea: false))
        }
        
        private func animations() -> Config.Animations {
            let behaviour: Config.Animation.Behaviour = .custom(
                changes: [.translation(type: .outOfSourceViewVerticaly)]
            )
            
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
            withDuration: 0.25,
            delay: .zero,
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
