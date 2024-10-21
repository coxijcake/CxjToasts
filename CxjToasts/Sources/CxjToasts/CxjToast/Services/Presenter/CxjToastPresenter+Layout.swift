//
//  CxjToastPresenter+Layout.swift
//  
//
//  Created by Nikita Begletskiy on 24/08/2024.
//

import UIKit

extension CxjToastPresenter {
	enum LayoutApplier {
		typealias Layout = CxjToastConfiguration.Layout
		typealias ToastView = CxjToastView
		
		//MARK: - Public API
		static func apply(
			layout: Layout,
			for toastView: ToastView,
			in sourceView: UIView
		) {
			let constraints = layout.constraints
			let placement = layout.placement
			
			toastView.translatesAutoresizingMaskIntoConstraints = false
			
			sourceView.addSubview(toastView)
			
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
			
			toastView.layoutIfNeeded()
		}
		
		//MARK: - Private API
		private static func verticalAnchorConstraint(
			for toastView: ToastView,
			placement: Layout.Placement,
			in sourceView: UIView
		) -> NSLayoutConstraint {
			switch placement {
			case .top(params: let params):
				if params.includingSafeArea {
					toastView.topAnchor
						.constraint(equalTo: sourceView.safeAreaLayoutGuide.topAnchor, constant: params.offset)
				} else {
					toastView.topAnchor
						.constraint(equalTo: sourceView.topAnchor, constant: params.offset)
				}
			case .center:
				toastView.centerYAnchor.constraint(equalTo: sourceView.centerYAnchor)
			case .bottom(params: let params):
				if params.includingSafeArea {
					toastView.bottomAnchor
						.constraint(equalTo: sourceView.safeAreaLayoutGuide.bottomAnchor, constant: -params.offset)
				} else {
					toastView.bottomAnchor
						.constraint(equalTo: sourceView.bottomAnchor, constant: -params.offset)
				}
			}
		}
	}
}
