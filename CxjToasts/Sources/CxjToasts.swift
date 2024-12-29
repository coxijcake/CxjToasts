//
//  CxjToasts.swift
//  CxjToasts
//
//  Created by Nikita Begletskiy on 21/12/2024.
//

import Foundation

@MainActor
public enum CxjToasts {
    public static func start() {
        let _ = CxjToastsCoordinator.shared
    }
}
