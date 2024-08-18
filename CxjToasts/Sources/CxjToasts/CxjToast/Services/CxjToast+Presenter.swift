//
//  CxjToast+Presenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
protocol CxjToastPresenter {
    func present(toast: CxjToast)
}
