//
//  ToastConfigProvider+TopStraight.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 11/11/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class TopStraightToastConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.TopStraightToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			let sourceView: UIView = data.customSourceView ?? defaultSourceView()
			
			return Config(
				typeId: data.typeId,
				sourceView: sourceView,
				sourceBackground: sourceBackground(),
				layout: layoutFor(sourceView: sourceView),
				dismissMethods: dismissMethods(),
				keyboardHandling: .ignore,
				animations: animations(),
				hapticFeeback: data.hapticFeeback,
				spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
			)
		}
		
		private func sourceBackground() -> Config.SourceBackground? {
			nil
		}
		
		private func layoutFor(sourceView: UIView) -> Config.Layout {
			Config.Layout(
				constraints: constraintsFor(sourceView: sourceView),
				placement: placement()
			)
		}
		
		private func constraintsFor(sourceView: UIView) -> Config.Constraints {
			Config.Constraints(
				width: widthConstraintFor(sourceView: sourceView),
				height: heightConstraint()
			)
		}
		
		private func widthConstraintFor(sourceView: UIView) -> Config.Constraints.Values {
			Config.Constraints.Values(
				min: sourceView.bounds.size.width,
				max: sourceView.bounds.size.width
			)
		}
		
		private func heightConstraint() -> Config.Constraints.Values {
			Config.Constraints.Values(
				min: 55,
				max: 65
			)
			
		}
		
		private func placement() -> Config.Layout.Placement {
			.top(params: .init(offset: .zero, includingSafeArea: true))
		}
		
		private func dismissMethods() -> Set<Config.DismissMethod> {
			[
				.automatic(time: 3.0),
				.swipe(direction: .top),
				.tap(actionCompletion: nil)
			]
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
				comparisonCriteria: .init(
					attibutes: [.sourceView, .type, .placement(includingYOffset: true)],
					rule: .and
				)
			)
		}
		
        private func coexistencePolicy() -> Config.ToastCoexistencePolicy {
            .init(handling: .dismiss, comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and))
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
