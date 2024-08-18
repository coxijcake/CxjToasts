//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
protocol CxjToastable {
    var view: CxjToastView { get }
    var config: CxjToastConfiguration { get }
    
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

extension CxjToast: CxjToastable {
    public static func show(
        _ type: ToastType,
        with content: ContentView
    ) {
        let toast: CxjToastable = CxjToastFactory.toastFor(
            type: type,
            content: content
        )
        
        CxjToastPresenter.present(toast: toast)
        
    }
}
