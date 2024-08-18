//
//  CxjToast+ToastType.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

extension CxjToast {
    public enum ToastType {
        case custom(config: CxjToastConfiguration, viewConfig: CxjToastViewConfiguration)
        case native
    }
}
