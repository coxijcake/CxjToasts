//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

protocol Toastable {
    
}

public extension CxjToast {
    typealias Toast = CxjToast
    typealias ToastView = CxjToastView
    typealias Configuration = CxjToastConfiguration
    typealias Content = CxjToastContentView
}

@MainActor
public final class CxjToast {
    //MARK: - Props
    let view: ToastView
    let config: Configuration
    
    //MARK: - Lifecycle
    init(
        view: ToastView,
        config: Configuration
    ) {
        self.view = view
        self.config = config
    }
}

//MARK: - Public API
extension CxjToast {
    public static func show(
        _ type: ToastType,
        content: Content
    ) {
        let toast: Toast = Factory.createToast(
            type: type,
            content: content
        )
        
    }
}
