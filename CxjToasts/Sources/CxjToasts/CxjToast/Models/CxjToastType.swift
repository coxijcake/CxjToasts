//
//  CxjToastType.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import Foundation

public enum CxjToastType {
    case custom(config: CxjToastConfiguration, viewConfig: CxjToastViewConfiguration)
    case native
}
