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
	
	private func showToast(after: TimeInterval? = nil) {
		DispatchQueue.main.asyncAfter(deadline: .now() + (after ?? .zero)) {
			
			let contentView: CxjToastContentView = self.customCxjToastContentView()
			
			let testConentView = TestContentView()
			testConentView.backgroundColor = .red
			
//			CxjToast.show(.native, with: contentView)
			CxjToast.show(
				.custom(
					config: self.customToastConfig(),
					viewConfig: self.customToastViewConfog()
				),
				with: contentView
			)
		}
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
	
	private func customToastConfig() -> CxjToastConfiguration {
		CxjToastConfiguration(
			sourceView: CxjToastTheme.native.sourceView,
			layout: CxjToastTheme.native.layout,
			dismissMethods: CxjToastTheme.native.dismissMethods,
			animations: CxjToastTheme.native.animations
		)
	}
	
	private func customToastViewConfog(sourceView: UIView = CxjToastTheme.native.sourceView) -> CxjToastViewConfiguration {
		CxjToastViewConfiguration(
			contentInsets: CxjToastTheme.native.viewContentInsets,
			colors: CxjToastTheme.native.viewColors,
			shadow: CxjToastTheme.native.viewShadow,
			cornerRadius: CxjToastTheme.native.viewCornerRadius
		)
	}
}


final class TestContentView: UIView, CxjToastContentView {
    
}
