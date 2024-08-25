//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

protocol CxjToastable: AnyObject {
    var view: CxjToastView { get }
    var config: CxjToastConfiguration { get }
	
	var presenter: CxjToastPresenter { get }
	var dismisser: CxjToastDismisser { get }
    
    static func show(
        _ type: CxjToastType,
        with content: CxjToastContentView
    )
}

public extension CxjToast {
    typealias ToastType = CxjToastType
    typealias ToastView = CxjToastView
    typealias Configuration = CxjToastConfiguration
    typealias ContentView = CxjToastContentView
}

public final class CxjToast: CxjToastable {
    //MARK: - Props
    let view: ToastView
    let config: Configuration
	
	private(set) lazy var animator: CxjToastAnimator = CxjToastAnimator(
		toastView: view,
		config: config
	)
	
	private(set) lazy var presenter: CxjToastPresenter = CxjToastPresenter(
		config: config,
		toastView: view,
		animator: animator
	)
	
	private(set) lazy var dismisser: CxjToastDismisser = CxjToastDismisser(
		toastView: view,
		methods: config.hidingMethods,
		animator: animator,
		onDismiss: onDismissAction()
	)
	
	private static var activeToast: [CxjToastable] = []
	
    //MARK: - Lifecycle
    init(
        view: ToastView,
        config: Configuration
    ) {
        self.view = view
        self.config = config
    }
	
	deinit {
		print("OMG Cxj toast deinit")
	}
}

//MARK: - Private
private extension CxjToast {
	func onDismissAction() -> VoidCompletion {
		return { [weak self] in
			guard let self else { return }
			
			CxjToast.activeToast.removeLast()
		}
	}
}


//MARK: - Public static
extension CxjToast {
    public static func show(
        _ type: ToastType,
        with content: ContentView
    ) {
        let toast: CxjToastable = CxjToastFactory.toastFor(
            type: type,
            content: content
        )
		
		activeToast.append(toast)
        
		toast.presenter.present()
		toast.dismisser.activate()
    }
}
