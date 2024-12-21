//
//  ToastConfigProvider+Native.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class NativeToastConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.NativeToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			let sourceView: UIView = defaultSourceView()
			
			return Config(
				typeId: data.typeId,
				sourceView: sourceView,
				sourceBackground: nil,
				layout: layoutFor(sourceView: sourceView),
				dismissMethods: dismissMethods(),
				keyboardHandling: .ignore,
				animations: animations(),
				spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
			)
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
				min: 200,
				max: sourceView.bounds.size.width - 24 * 2
			)
		}
		
		private func heightConstraint() -> Config.Constraints.Values {
			Config.Constraints.Values(
				min: 50,
				max: 60
			)
		}
		
		private func placement() -> Config.Layout.Placement {
			.top(params: .init(offset: 20, includingSafeArea: true))
		}
		
		private func dismissMethods() -> Set<Config.DismissMethod> {
			[
				.automatic(time: 2.0),
				.swipe(direction: .top)
			]
		}
		
		private func animations() -> Config.Animations {
			let present: Config.Animation = Config.Animation(
				animation: .toastPresenting,
				behaviour: .default(includingNativeViews: [.dynamicIsland])
			)
			
			let dismiss: Config.Animation = Config.Animation(
				animation: .toastDismissing,
				behaviour: .default(includingNativeViews: [.dynamicIsland])
			)
			
			return Config.Animations(
				present: present,
				dismiss: dismiss
			)
		}
		
		private func spamProtection() -> Config.SpamProtection {
			.off
		}
		
		private func coexistencePolicy() -> Config.ToastCoexistencePolicy {
			.init(
				handling: .stack(
					attributes: .init(maxVisibleToasts: 5, shouldStopTimerForStackedUnvisibleToasts: false)
				),
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
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 10.0,
            options: [.curveEaseOut, .allowUserInteraction, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
    
    static let toastDismissing = CxjAnimation { (animations, completion) in
        UIView.animate(
            withDuration: 0.25,
            delay: .zero,
            options: [.curveEaseIn, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
}
