//
//  ViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit
import CxjToasts

class ViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
        
        view.backgroundColor = .gray
	}


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//		showToast(after: 2)
//        showToast(after: 5)
//        showToast(after: 10)
    }
    
	@IBAction func customButtonPressed(_ sender: Any) {
		CxjToastsCoordinator.shared.showToast(
			type: .custom(
				config: customCxjTostConfig(),
				viewConfig: customCxjToastViewConfig(),
				content: customCxjToastContentView()
			)
		)
	}
	
	@IBAction func nativeButtonPressed(_ sender: Any) {
		CxjToastsCoordinator.shared.showToast(
			type: .templated(
				template: .native(
					data: CxjToastTemplate.NativeToastData(
						title: "Test Toast Toast Toast",
						subtitle: "some description",
						icon: .init(resource: .testIcon),
						backgroundColor: .white
					)
				)
			)
		)
	}
	
	@IBAction func bottomPrimaryButtonPressed(_ sender: Any) {
		CxjToastsCoordinator.shared.showToast(
			type: .templated(
				template: .bottomPrimary(
					data: CxjToastTemplate.BottomPrimaryToastData(
						customSourceView: nil,
						icon: .init(resource: .testIcon),
						title: CxjToastTemplate.BottomPrimaryToastData.Title(
							text: "owofmqwofmqowf qowfm qowfmq owfmqow fqowf m",
							numberOfLines: 3,
							textColor: UIColor.black,
							font: .systemFont(ofSize: 21, weight: .bold)
						),
						subtitle: nil,
						background: .colorized(color: .white),
						shadowColor: .black.withAlphaComponent(0.5)
					)
				)
			)
		)
	}
	
	private func customCxjToastContentView() -> CxjToastContentView {
		CxjToastContentViewFactory.createContentViewWith(
			config: CxjToastContentConfiguration.iconed(
				config: .init(
					params: .init(
						iconPlacement: .left
					),
					iconParams: .init(
						icon: .init(resource: .testIcon),
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
    
	private func customCxjTostConfig() -> CxjToastConfiguration {
		let sourceView: UIView = view
		
		let sourceBackground: CxjToastConfiguration.SourceBackground = .init(
			theme: .blurred(effect: .init(style: .dark)),
			interaction: .enabled(
				action: .init(
					touchEvent: .touchUpInside,
					handling: .custom(completion: { toast in
						print("OMG toast \(toast.id) background pressed")
						CxjToastsCoordinator.shared.dismissAll(animated: true)
					})
				)
			)
		)
		
		return CxjToastConfiguration(
			typeId: "custom test toast",
			sourceView: sourceView,
//			sourceBackground: sourceBackground,
			sourceBackground: nil,
			layout: CxjToastConfiguration.Layout(
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
			),
			dismissMethods: [
				.swipe(direction: .bottom),
				.tap(actionCompletion: nil),
				.automatic(time: 3.0)
			],
			animations: CxjToastConfiguration.Animations(
				present: .init(
					animation: .defaultSpring,
					behaviour: .custom(changes: [.translation(type: .outOfSourceViewVerticaly)])
				),
				dismiss: .init(
					animation: .defaultSpring,
					behaviour: .custom(changes: [.alpha(intensity: .zero), .scale(value: .init(x: 0.9, y: 0.75))])
				)
			),
//			spamProtection: .on(comparingAttributes: [.type, .placement(includingYOffset: false)]),
			spamProtection: .off,
			displayingSameAttributeToastBehaviour: .init(handling: .dismiss)
		)
	}
    
    private func customCxjToastViewConfig() -> CxjToastViewConfiguration {
        CxjToastViewConfiguration(
            contentInsets: .init(top: 20, left: 16, bottom: 20, right: 16),
//			background: .blurred(effect: .init(style: .extraLight)),
			background: .gradient(
				params: .init(
					colors: [.black.withAlphaComponent(0.95), .black.withAlphaComponent(0.5)],
					locations: [0, 1],
					direction: .init(startPoint: .init(x: 0.1, y: 0.25),
									 endPoint: .init(x: 0.8, y: 0.75))
				)
			),
            shadow: .disable,
			corners: .straight(mask: .top)
        )
    }
}


final class TestContentView: UIView, CxjToastContentView {
    
}
