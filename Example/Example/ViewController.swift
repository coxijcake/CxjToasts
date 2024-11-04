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
        
		let customVC = CustomToastViewController.storyboardInstantiateInitialController()
		present(customVC, animated: true)
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
}


final class TestContentView: UIView, CxjToastContentView {
    
}
