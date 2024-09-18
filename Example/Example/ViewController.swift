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
        let customContentView: CxjToastContentView = self.customCxjToastContentView()
        
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
//            .template(
//                theme: .native(
//                    data: CxjToastTheme.NativeToastData(
//                        title: "Test Toast Toast Toast",
//                        subtitle: "some description",
//                        icon: UIImage.checkmark
//                    )
//                )
//            )
//        )
	}
	
	private func customCxjToastContentView() -> CxjToastContentView {
		CxjToastContentViewFactory.createContentViewWith(
			config: CxjToastContentConfiguration.titled(
				config: CxjToastTitlesConfiguration.plain(
					config: CxjToastTitlesConfiguration.Plain(
						title: CxjToastTitlesConfiguration.PlainLabel(
							text: "Test Toast",
							labelParams: CxjToastTitlesConfiguration.LabelParams(
								numberOfLines: 1,
								textAligment: .center
							)
						),
						subtitle: .init(
							text: "Teat Toast subtitle longlonglonglonglonglong \n longlonglonglonglonglong",
							labelParams: .init(
								numberOfLines: .zero,
								textAligment: .center
							)
						)
					)
				)
			)
		)
	}
    
    private func customCxjTostConfig() -> CxjToastConfiguration {
        CxjToastConfiguration(
            sourceView: containerView,
            layout: CxjToastConfiguration.Layout(
                constraints: CxjToastConfiguration.Constraints(
                    width: CxjToastConfiguration.Constraints.Values(
                        min: containerView.bounds.size.width,
                        max: containerView.bounds.size.width
                    ),
                    height: CxjToastConfiguration.Constraints.Values(
                        min: 40,
                        max: 70
                    )
                ),
                placement: .top(verticalOffset: 0)
//                placement: .bottom(verticalOffset: 0)
//                placement: .center
            ),
            dismissMethods: [.swipe(direction: .top), .tap, .automatic(time: 3.0)],
            animations: CxjToastConfiguration.Animations(
                present: .nativeToastPresenting,
                dismiss: .nativeToastDismissing,
                changes: [.translation, .scale, .alpha],
                nativeViewsIncluding: []
            )
        )
    }
    
    private func customCxjToastViewConfig() -> CxjToastViewConfiguration {
        CxjToastViewConfiguration(
            contentInsets: .init(top: 20, left: 16, bottom: 20, right: 16),
            colors: CxjToastViewConfiguration.Colors(background: .white),
            shadow: .disable,
            corners: .straight
        )
    }
}


final class TestContentView: UIView, CxjToastContentView {
    
}
