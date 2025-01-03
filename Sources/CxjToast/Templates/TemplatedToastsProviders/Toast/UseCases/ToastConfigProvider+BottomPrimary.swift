//
//  ToastConfigProvider+BottomPrimary.swift
//  
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class BottomPrimaryToastConfigProvider: CxjTemplatedToastConfigProvider {
		typealias Data = CxjToastTemplate.BottomPrimaryToastData
		
		let data: Data
		
		init(data: Data) {
			self.data = data
		}
		
		func config() -> Config {
			let sourceView: UIView = data.customSourceView ?? defaultSourceView()
			
			return Config(
				typeId: data.typeId,
				sourceView: sourceView,
				sourceBackground: sourceBackgroundForData(data),
				layout: layoutFor(sourceView: sourceView),
				dismissMethods: data.dismissMethods,
				keyboardHandling: .ignore,
				animations: animations(),
				hapticFeeback: data.hapticFeeback,
				spamProtection: spamProtection(),
                coexistencePolicy: coexistencePolicy()
			)
		}
		
		private func sourceBackgroundForData(_ data: Data) -> Config.SourceBackground? {
			data.sourceBackground
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
				min: sourceView.bounds.size.width - 24,
				max: sourceView.bounds.size.width - 24
			)
		}
		
		private func heightConstraint() -> Config.Constraints.Values {
			Config.Constraints.Values(
				min: 145,
				max: 250
			)
		}
		
		private func placement() -> Config.Layout.Placement {
			.bottom(params: .init(offset: 12, includingSafeArea: true))
		}
		
		private func animations() -> Config.Animations {
			let animation: Config.Animation = Config.Animation(
				animation: .defaultSpring,
				behaviour: .custom(
					changes: [
						.translation(type: .outOfSourceViewVerticaly),
						.corners(radius: .init(type: .screenCornerRadius, constraint: .halfHeigt)),
						.scale(value: .init(x: 1.1, y: 1.1))
					]
				)
			)
			
			return Config.Animations(
				present: animation,
				dismiss: animation
			)
		}
		
		private func spamProtection() -> Config.SpamProtection {
            .on(comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and))
		}
		
		private func coexistencePolicy() -> Config.ToastCoexistencePolicy {
			.init(
				handling: .hide(attributes: .init(shouldStopTimerForHiddenToasts: false)),
                comparisonCriteria: .init(attibutes: CxjToastComparisonAttribute.completeMatch, rule: .and)
			)
		}
	}
}
