//
//  ToastConfigProvider+Native.swift
//
//
//  Created by Nikita Begletskiy on 08/10/2024.
//

import UIKit

extension CxjTemplatedToastConfigProviderFactory {
	final class NativeToastConfigProvider: CxjTemplatedToastConfigProvider {
		func config() -> Config {
			let sourceView: UIView = sourceView()
			
			return Config(
				typeId: "cxj_native_toast",
				sourceView: sourceView,
				sourceBackground: nil,
				layout: layoutFor(sourceView: sourceView),
				dismissMethods: dismissMethods(),
				animations: animations()
			)
		}
		
		private func sourceView() -> UIView {
			UIApplication.keyWindow ?? UIApplication.topViewController()?.view ?? UIView()
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
				animation: .nativeToastPresenting,
				behaviour: .default,
				nativeViewsIncluding: [.dynamicIsland, .notch]
			)
			
			let dismiss: Config.Animation = Config.Animation(
				animation: .nativeToastDismissing,
				behaviour: .default,
				nativeViewsIncluding: [.dynamicIsland, .notch]
			)
			
			return Config.Animations(
				present: present,
				dismiss: dismiss
			)
		}
	}
}
