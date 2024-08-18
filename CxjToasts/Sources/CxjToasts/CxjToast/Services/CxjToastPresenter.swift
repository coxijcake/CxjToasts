//
//  CxjToastPresenter.swift
//
//
//  Created by Nikita Begletskiy on 16/08/2024.
//

import UIKit

@MainActor
enum CxjToastPresenter {
    static func present(toast: CxjToastable) {
        let config = toast.config
        let toastView = toast.view
        
        config.sourceView.addSubview(toastView)
        setup(
            layout: config.layout,
            for: toastView,
            in: config.sourceView
        )
        
        config.sourceView.layoutSubviews()
        
        print(toastView.frame)
    }
    
    private static func setup(
        layout: CxjToastConfiguration.Layout,
        for toastView: CxjToastView,
        in sourceView: UIView
    ) {
        let constraints = layout.constraints
        let placement = layout.placement
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let vetricalAnchorConstraint: NSLayoutConstraint = verticalAnchorConstraint(
            for: toastView,
            placement: placement,
            in: sourceView
        )
        
        NSLayoutConstraint.activate([
            toastView.widthAnchor.constraint(greaterThanOrEqualToConstant: constraints.width.min),
            toastView.widthAnchor.constraint(lessThanOrEqualToConstant: constraints.width.max),
            toastView.heightAnchor.constraint(greaterThanOrEqualToConstant: constraints.height.min),
            toastView.heightAnchor.constraint(lessThanOrEqualToConstant: constraints.height.max),
            toastView.leadingAnchor.constraint(greaterThanOrEqualTo: sourceView.safeAreaLayoutGuide.leadingAnchor),
            toastView.trailingAnchor.constraint(lessThanOrEqualTo: sourceView.safeAreaLayoutGuide.trailingAnchor),
            toastView.centerXAnchor.constraint(equalTo: sourceView.centerXAnchor),
            vetricalAnchorConstraint
        ])
    }
    
    private static func verticalAnchorConstraint(
        for toastView: CxjToastView,
        placement: CxjToastConfiguration.Placement,
        in sourceView: UIView
    ) -> NSLayoutConstraint {
        switch placement {
        case .top:
            return toastView.topAnchor.constraint(equalTo: sourceView.safeAreaLayoutGuide.topAnchor, constant: .zero)
        case .center:
            return toastView.centerYAnchor.constraint(equalTo: sourceView.centerYAnchor)
        case .bottom:
            return toastView.bottomAnchor.constraint(equalTo: sourceView.safeAreaLayoutGuide.bottomAnchor, constant: .zero)
        }
    }
}
