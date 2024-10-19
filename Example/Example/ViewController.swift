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
    
	@IBAction func showButtonPressed(_ sender: Any) {
		showToast()
	}
	
	private func showToast() {
//        let customContentView: CxjToastContentView = self.customCxjToastContentView()
        
        let testConentView = TestContentView()
        testConentView.backgroundColor = .red
        
        CxjToast.show(
            .custom(
                config: self.customCxjTostConfig(),
                viewConfig: self.customCxjToastViewConfig(),
                content: self.customCxjToastContentView()
            )
        )
        
//        CxjToast.show(
//            .templated(
//				template: .native(
//                    data: CxjToastTemplate.NativeToastData(
//                        title: "Test Toast Toast Toast",
//                        subtitle: "some description",
//                        icon: .init(resource: .testIcon),
//						backgroundColor: .white
//                    )
//                )
//            )
//        )
		
//		CxjToast.show(
//			.templated(
//				template: .bottomPrimary(
//					data: CxjToastTemplate.BottomPrimaryToastData(
//						customSourceView: nil,
//						icon: .init(resource: .testIcon),
//						title: CxjToastTemplate.BottomPrimaryToastData.Title(
//							text: "owofmqwofmqowf qowfm qowfmq owfmqow fqowf m",
//							numberOfLines: 3,
//							textColor: UIColor.black,
//							font: .systemFont(ofSize: 21, weight: .bold)
//						),
//						subtitle: nil,
//						background: .colorized(color: .white),
//						shadowColor: .black.withAlphaComponent(0.5)
//					)
//				)
//			)
//		)
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
									numberOfLines: 2,
									textAligment: .left
								)
							),
							subtitle: .init(
								text: "Teast toast long long long\nlong long long long boring subtitle",
								labelParams: .init(
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
		
       return CxjToastConfiguration(
			sourceView: sourceView,
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
				placement: .bottom(params: .init(offset: 200, includingSafeArea: true))
            ),
            dismissMethods: [
				.swipe(direction: .bottom),
				.tap(actionCompletion: nil),
				.automatic(time: 3.0)
			],
            animations: CxjToastConfiguration.Animations(
                present: .nativeToastPresenting,
                dismiss: .nativeToastDismissing,
				behaviour: .custom(
					changes: [
						.translation(type: .outOfSourceViewVerticaly),
//						.shadowOverlay(color: .black, intensity: 0.5),
//						.corners(
//							radius: .init(
//								type: .screenCornerRadius,
//								constraint: .halfHeigt
//							)
//						)
//						.alpha(intensity: 0.0)
					]
				),
                nativeViewsIncluding: []
            )
        )
    }
    
    private func customCxjToastViewConfig() -> CxjToastViewConfiguration {
        CxjToastViewConfiguration(
            contentInsets: .init(top: 20, left: 16, bottom: 20, right: 16),
//			background: .blurred(effect: .init(style: .extraLight)),
			background: .gradient(
				params: .init(
					colors: [.white.withAlphaComponent(0.95), .white.withAlphaComponent(0.85)],
					locations: [0, 1],
					direction: .init(startPoint: .init(x: 0.1, y: 0.5),
									 endPoint: .init(x: 0.9, y: 0.5))
				)
			),
            shadow: .disable,
			corners: .straight(mask: .top)
        )
    }
}


final class TestContentView: UIView, CxjToastContentView {
    
}
