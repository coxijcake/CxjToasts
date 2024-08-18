//
//  CxjToast.swift
//  
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
public protocol CxjToast {
    static func show(
        _ type: CxjToastType,
        content: CxjToastContentView
    )
}

extension CxjCommonToast {
    typealias Toast = CxjToast
    typealias ToastType = CxjToastType
    typealias ToastView = CxjToastView
    typealias Configuration = CxjToastConfiguration
    typealias ContentView = CxjToastContentView
}

@MainActor
final class CxjCommonToast {
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

extension CxjCommonToast: CxjToast {
    static func show(_ type: ToastType, content: ContentView) {
        let toast: Toast = CxjToastFactory.createToast(
            type: type,
            content: content
        )
        
        
        
    }
}
