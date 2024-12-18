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
                displayingSameAttributeToastBehaviour: displayingBehaviour()
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
            let minHeight: CGFloat = 55
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
            let animation: Config.Animation = Config.Animation(
                animation: .defaultSpring,
                behaviour: .custom(changes: [.translation(type: .outOfSourceViewVerticaly)])
            )
            
            return Config.Animations(
                present: animation,
                dismiss: animation
            )
        }
        
        private func spamProtection() -> Config.SpamProtection {
            .on(
                comparisonCriteria: .init(rule: .and)
            )
        }
        
        private func displayingBehaviour() -> Config.DisplayingBehaviour {
            .init(
                handling: .dismiss,
                comparisonCriteria: .init(rule: .and)
            )
        }
    }
}
