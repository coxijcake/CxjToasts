//
//  CustomToastFactory.swift
//  Example
//
//  Created by Nikita Begletskiy on 09/11/2024.
//

import UIKit
import CxjToasts

enum CustomToastFactory {
	typealias ToastConfig = CxjToastConfiguration
	typealias ToastData = CxjToastType.CustomToastData
	
	static func toastDataForType(
		_ toastType: CustomToastType,
		customSourceView: UIView?
	) -> ToastData {
		let sourceView: UIView = customSourceView
		?? UIApplication.keyWindow
		?? UIApplication.topViewController()?.view
		?? UIView()
		
		switch toastType {
		case .bottomGradientedWithBlurredBackground:
			return BottomGradientWithBlurredBackgroundToastDataConfigurator.toastData(
				withSoureView: sourceView
			)
		}
	}
}

extension CustomToastFactory {
	enum BottomGradientWithBlurredBackgroundToastDataConfigurator {
		static func toastData(withSoureView soureView: UIView) -> ToastData {
			ToastData(
				config: config(withSourceView: soureView),
				viewConfig: viewConfig(),
				content: contentView()
			)
		}
		
		//MARK: - Config
		private static func config(withSourceView sourceView: UIView) -> ToastConfig {
			return ToastConfig(
				typeId: "custom test toast",
				sourceView: sourceView,
				sourceBackground: sourceBackground(),
				layout: layout(inSourceView: sourceView),
				dismissMethods: dismissMethods(),
				animations: animations(),
				spamProtection: spamProtection(),
				displayingSameAttributeToastBehaviour: displayingSameAttributeToastBehaviour()
			)
		}
		
		private static func sourceBackground() -> ToastConfig.SourceBackground? {
			let darkBlurredBackground: CxjToastConfiguration.SourceBackground = .init(
				theme: .blurred(effect: .init(style: .dark)),
				interaction: .enabled(
					action: .init(
						touchEvent: .touchUpInside,
						handling: .custom(completion: { toast in
							print("custom background view action for toat with id \(toast.id)")
							Task { @MainActor in
								CxjToastsCoordinator.shared.dismissAll(animated: true)
							}
						})
					)
				)
			)
			
			return darkBlurredBackground
		}
		
		private static func layout(inSourceView sourceView: UIView) -> ToastConfig.Layout {
			CxjToastConfiguration.Layout(
				constraints: CxjToastConfiguration.Constraints(
					width: CxjToastConfiguration.Constraints.Values(
						min: sourceView.bounds.size.width * 0.75,
						max: sourceView.bounds.size.width
					),
					height: CxjToastConfiguration.Constraints.Values(
						min: 40,
						max: 150
					)
				),
				placement: .bottom(params: .init(offset: 100, includingSafeArea: true))
			)
		}
		
		private static func dismissMethods() -> Set<ToastConfig.DismissMethod> {
			[
				.swipe(direction: .bottom),
				.tap(actionCompletion: nil),
				.automatic(time: 3.0)
			]
		}
		
		private static func animations() -> ToastConfig.Animations {
			ToastConfig.Animations(
				present: presentAnimation(),
				dismiss: dismissAnimation()
			)
		}
		
		private static func presentAnimation() -> ToastConfig.Animation {
			ToastConfig.Animation(
				animation: .defaultSpring,
				behaviour: .custom(changes: [.translation(type: .outOfSourceViewVerticaly)])
			)
		}
		
		private static func dismissAnimation() -> ToastConfig.Animation {
			ToastConfig.Animation(
				animation: .defaultSpring,
				behaviour: .custom(changes: [.alpha(intensity: .zero), .scale(value: .init(x: 0.9, y: 0.75))])
			)
		}
		
		private static func spamProtection() -> ToastConfig.SpamProtection {
			.off
		}
		
		private static func displayingSameAttributeToastBehaviour() -> ToastConfig.DisplayingBehaviour {
			.init(handling: .dismiss)
		}
		
		//MARK: - ViewConfig
		private static func viewConfig() -> CxjToastViewConfiguration {
			CxjToastViewConfiguration(
				contentInsets: .init(top: 20, left: 16, bottom: 20, right: 16),
				background: .gradient(
					params: .init(
						colors: [.black.withAlphaComponent(0.95), .black.withAlphaComponent(0.5)],
						locations: [0, 1],
						direction: .init(startPoint: .init(x: 0.1, y: 0.25),
										 endPoint: .init(x: 0.8, y: 0.75))
					)
				),
				shadow: .disable,
				corners: .fixed(value: 16, mask: .all)
			)
		}
		
		//MARK: - Content
		private static func contentView() -> CxjToastContentView {
			CxjToastContentViewFactory.createContentViewWith(
				config: CxjToastContentConfiguration.iconed(
					config: .init(
						params: .init(
							iconPlacement: .left,
							paddingToTitle: 16
						),
						iconParams: .init(
							icon: .init(resource: .closeIcon),
							fixedSize: .init(width: 20, height: 20)
						)
					),
					titlesConfig: .init(
						layout: .init(labelsPadding: 4),
						titles: .plain(
							config: .init(
								title: .init(
									text: "Teast Toast title",
									labelParams: .init(
										textColor: .white,
										font: .systemFont(ofSize: 15, weight: .bold),
										numberOfLines: 2,
										textAligment: .left
									)
								),
								subtitle: .init(
									text: "Teast toast long long long\nlong long long long boring subtitle",
									labelParams: .init(
										textColor: .white.withAlphaComponent(0.85),
										font: .systemFont(ofSize: 14, weight: .regular),
										numberOfLines: .zero,
										textAligment: .left
									)
								)
							)
						)
					)
				)
			)
		}
	}
}
