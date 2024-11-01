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
				typeId: "cxj_bottom_primary_toast",
				sourceView: sourceView, 
				sourceBackground: sourceBackground(),
				layout: layoutFor(sourceView: sourceView),
				dismissMethods: dismissMethods(),
				animations: animations()
			)
		}
		
		private func defaultSourceView() -> UIView {
			UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
		}
		
		private func sourceBackground() -> Config.SourceBackground {
			.init(
				theme: .colorized(color: .blue.withAlphaComponent(0.65)),
				interaction: .enabled(action: .init(touchEvent: .touchDown, handling: .dismissToast))
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
				min: sourceView.bounds.size.width - 24,
				max: sourceView.bounds.size.width - 24
			)
		}
		
		private func heightConstraint() -> Config.Constraints.Values {
			Config.Constraints.Values(
				min: 145,
				max: 200
			)
			
		}
		
		private func placement() -> Config.Layout.Placement {
			.bottom(params: .init(offset: 12, includingSafeArea: true))
		}
		
		private func dismissMethods() -> Set<Config.DismissMethod> {
			[
				.automatic(time: 3.0),
				.swipe(direction: .bottom)
			]
		}
		
		private func animations() -> Config.Animations {
			let animation: Config.Animation = Config.Animation(
				animation: .testSlow,
				behaviour: .custom(
					changes: [
						.translation(type: .outOfSourceViewVerticaly),
						.corners(radius: .init(type: .screenCornerRadius, constraint: .halfHeigt)),
						.scale(value: .init(x: 1.1, y: 1.1))
					]
				),
				nativeViewsIncluding: []
			)
			
			return Config.Animations(
				present: animation,
				dismiss: animation
			)
		}
	}
}
