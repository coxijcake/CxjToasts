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
			
			let customContentView: CxjToastContentView = self.customCxjToastContentView()
			
			let testConentView = TestContentView()
			testConentView.backgroundColor = .red
			
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
}


final class TestContentView: UIView, CxjToastContentView {
    
}
