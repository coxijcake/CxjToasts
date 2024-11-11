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
				animations: animations(),
				spamProtection: spamProtection(),
				displayingSameAttributeToastBehaviour: displayingBehaviour()
			)
		}
		
		private func defaultSourceView() -> UIView {
			UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
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
			let animation: Config.Animation = Config.Animation(
				animation: .defaultSpring,
				behaviour: .custom(
					changes: [
						.translation(type: .outOfSourceViewVerticaly)
					]
				)
			)
			
			return Config.Animations(
				present: animation,
				dismiss: animation
			)
		}
		
		private func spamProtection() -> Config.SpamProtection {
			.on(comparingAttributes: [.type, .placement(includingYOffset: true)])
		}
		
		private func displayingBehaviour() -> Config.DisplayingBehaviour {
			.init(handling: .dismiss)
		}
	}
}

