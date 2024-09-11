//
//  ViewController.swift
//  Example
//
//  Created by Nikita Begletskiy on 15/08/2024.
//

import UIKit
import CxjToasts

class ViewController: UIViewController {

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
        
//        CxjToast.show(
//            .custom(
//                config: self.customCxjTostConfig(),
//                viewConfig: self.customCxjToastViewConfig(),
//                content: self.customCxjToastContentView()
//            )
//        )
        
        CxjToast.show(
            .template(
                theme: .native(
                    data: CxjToastTheme.NativeToastData(
                        title: "Test Toast Toast Toast",
                        subtitle: "some description",
                        icon: UIImage.checkmark
                    )
                )
            )
        )
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
							text: "Teat Toast subtitle longlonglonglonglonglong \n longlonglonglonglonglong \ntext",
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
            sourceView: self.view,
            layout: CxjToastConfiguration.Layout(
                constraints: CxjToastConfiguration.Constraints(
                    width: CxjToastConfiguration.Constraints.Values(
                        min: UIScreen.main.bounds.size.width,
                        max: UIScreen.main.bounds.size.width
                    ),
                    height: CxjToastConfiguration.Constraints.Values(
                        min: 100,
                        max: 150
                    )
                ),
                placement: .top(verticalOffset: .zero)
            ),
            dismissMethods: [.tap, .automatic(time: 5.0)],
            animations: CxjToastConfiguration.Animations(
                present: .defaultSpring,
                dismiss: .defaultSpring
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
